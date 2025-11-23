#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define MAX_UNIQUE_VARS 200 // Max 2 * 100 equations
static char* var_names[MAX_UNIQUE_VARS];
static int var_count;

typedef struct {
    int neighbor_id;
    double weight;
} Edge;

typedef struct {
    Edge* edges;
    int count;
    int capacity;
} AdjList;

static AdjList graph[MAX_UNIQUE_VARS];

static double current_dfs_result;
static bool visited_nodes[MAX_UNIQUE_VARS];

static int get_id(char* var_name) {
    for (int i = 0; i < var_count; ++i) {
        if (strcmp(var_names[i], var_name) == 0) {
            return i;
        }
    }
    // Not found, add new
    var_names[var_count] = strdup(var_name);
    return var_count++;
}

static int find_id(char* var_name) {
    for (int i = 0; i < var_count; ++i) {
        if (strcmp(var_names[i], var_name) == 0) {
            return i;
        }
    }
    return -1; // Not found
}

static void add_edge(int u, int v, double w) {
    if (graph[u].count == graph[u].capacity) {
        graph[u].capacity = (graph[u].capacity == 0) ? 2 : graph[u].capacity * 2;
        graph[u].edges = (Edge*)realloc(graph[u].edges, graph[u].capacity * sizeof(Edge));
    }
    graph[u].edges[graph[u].count].neighbor_id = v;
    graph[u].edges[graph[u].count].weight = w;
    graph[u].count++;
}

static void dfs(int start_node, int end_node, double product) {
    if (current_dfs_result != -1.0) return; // Path already found

    if (start_node == end_node) {
        current_dfs_result = product;
        return;
    }

    visited_nodes[start_node] = true;

    for (int i = 0; i < graph[start_node].count; ++i) {
        Edge edge = graph[start_node].edges[i];
        if (!visited_nodes[edge.neighbor_id]) {
            dfs(edge.neighbor_id, end_node, product * edge.weight);
            if (current_dfs_result != -1.0) return; // Propagate result up
        }
    }
}

double* calcEquation(char*** equations, int equationsSize, int* equationsColSize, double* values, int valuesSize, char*** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    // Reset global state for each test case
    for (int i = 0; i < var_count; ++i) {
        free(var_names[i]);
        if (graph[i].edges != NULL) {
            free(graph[i].edges);
        }
        graph[i].count = 0;
        graph[i].capacity = 0;
        graph[i].edges = NULL;
    }
    var_count = 0;

    // Build the graph
    for (int i = 0; i < equationsSize; ++i) {
        int u = get_id(equations[i][0]);
        int v = get_id(equations[i][1]);
        add_edge(u, v, values[i]);
        add_edge(v, u, 1.0 / values[i]);
    }

    // Prepare results array
    double* results = (double*)malloc(queriesSize * sizeof(double));
    *returnSize = queriesSize;

    // Process queries
    for (int i = 0; i < queriesSize; ++i) {
        int start_id = find_id(queries[i][0]);
        int end_id = find_id(queries[i][1]);

        if (start_id == -1 || end_id == -1) {
            results[i] = -1.0; // One or both variables not found in graph
        } else if (start_id == end_id) {
            results[i] = 1.0; // Division of a variable by itself
        } else {
            // Reset visited array for each DFS call
            for (int j = 0; j < var_count; ++j) {
                visited_nodes[j] = false;
            }
            current_dfs_result = -1.0; // Initialize result to -1.0 (not found)

            dfs(start_id, end_id, 1.0);
            results[i] = current_dfs_result;
        }
    }

    return results;
}