#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For memset
#include <stdio.h>  // For NULL, though not strictly needed here

typedef struct Edge {
    int to;
    int time;
} Edge;

typedef struct AdjList {
    Edge* edges;
    int count;
    int capacity;
} AdjList;

int g_n;
int* g_values;
int g_maxTime;
AdjList* g_adj;
int g_max_quality;
int g_visited_counts[100]; // To track how many times each node is visited in the current path

void add_edge(AdjList* list, int to, int time) {
    if (list->count == list->capacity) {
        list->capacity = list->capacity == 0 ? 2 : list->capacity * 2;
        list->edges = (Edge*)realloc(list->edges, list->capacity * sizeof(Edge));
        if (list->edges == NULL) {
            // Handle realloc failure, though LeetCode environment usually guarantees success
            exit(EXIT_FAILURE); 
        }
    }
    list->edges[list->count].to = to;
    list->edges[list->count].time = time;
    list->count++;
}

void dfs(int u, int current_time, int current_quality) {
    // If the current node is 0, this is a valid path ending. Update max_quality.
    if (u == 0) {
        if (current_quality > g_max_quality) {
            g_max_quality = current_quality;
        }
    }

    // Explore neighbors
    for (int i = 0; i < g_adj[u].count; ++i) {
        Edge neighbor_edge = g_adj[u].edges[i];
        int v = neighbor_edge.to;
        int time_to_v = neighbor_edge.time;

        // Pruning: if adding this edge exceeds maxTime, do not proceed
        if (current_time + time_to_v <= g_maxTime) {
            int new_quality = current_quality;
            // If node v is visited for the first time in this path, add its value to quality
            if (g_visited_counts[v] == 0) {
                new_quality += g_values[v];
            }

            g_visited_counts[v]++; // Mark v as visited in the current path
            dfs(v, current_time + time_to_v, new_quality);
            g_visited_counts[v]--; // Backtrack: unmark v
        }
    }
}

int maxPathQuality(int* values, int valuesSize, int** edges, int edgesSize, int* edgesColSize, int maxTime) {
    g_n = valuesSize;
    g_values = values;
    g_maxTime = maxTime;
    g_max_quality = 0;

    // Initialize adjacency list
    g_adj = (AdjList*)calloc(g_n, sizeof(AdjList));
    if (g_adj == NULL) {
        exit(EXIT_FAILURE);
    }

    // Build the graph (undirected)
    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        int time = edges[i][2];
        add_edge(&g_adj[u], v, time);
        add_edge(&g_adj[v], u, time);
    }

    // Initialize visited counts for all nodes to 0
    memset(g_visited_counts, 0, sizeof(int) * g_n);

    // Start DFS from node 0
    // Node 0 is always visited at least once at the start of the path.
    // Its value is added to the initial quality.
    g_visited_counts[0] = 1;
    dfs(0, 0, values[0]);

    // Free allocated memory for adjacency list
    for (int i = 0; i < g_n; ++i) {
        if (g_adj[i].edges != NULL) {
            free(g_adj[i].edges);
        }
    }
    free(g_adj);

    return g_max_quality;
}