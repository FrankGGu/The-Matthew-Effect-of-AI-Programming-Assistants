#include <stdlib.h>
#include <string.h>
#include <stdio.h> // Included for potential utility, not strictly for the solution logic itself

typedef struct AdjNode {
    int dest;
    struct AdjNode* next;
} AdjNode;

typedef struct Graph {
    int numVertices;
    AdjNode** adjLists;
    // Additional properties for vertices might be needed based on 'special' conditions
    // For example: int* values; // if nodes have associated values
} Graph;

AdjNode* createAdjNode(int dest) {
    AdjNode* newNode = (AdjNode*)malloc(sizeof(AdjNode));
    if (newNode == NULL) {
        // Handle allocation error
        exit(EXIT_FAILURE);
    }
    newNode->dest = dest;
    newNode->next = NULL;
    return newNode;
}

Graph* createGraph(int vertices) {
    Graph* graph = (Graph*)malloc(sizeof(Graph));
    if (graph == NULL) {
        // Handle allocation error
        exit(EXIT_FAILURE);
    }
    graph->numVertices = vertices;
    graph->adjLists = (AdjNode**)malloc(vertices * sizeof(AdjNode*));
    if (graph->adjLists == NULL) {
        // Handle allocation error
        free(graph);
        exit(EXIT_FAILURE);
    }

    for (int i = 0; i < vertices; i++) {
        graph->adjLists[i] = NULL;
    }
    return graph;
}

void addEdge(Graph* graph, int src, int dest) {
    // Add edge from src to dest
    AdjNode* newNode = createAdjNode(dest);
    newNode->next = graph->adjLists[src];
    graph->adjLists[src] = newNode;

    // Add edge from dest to src (for undirected graph)
    newNode = createAdjNode(src);
    newNode->next = graph->adjLists[dest];
    graph->adjLists[dest] = newNode;
}

int dfs(Graph* graph, int u, int parent, int* dp_memo, int* node_values) {
    if (dp_memo[u] != -1) {
        return dp_memo[u];
    }

    int max_path_len = 0; // Represents the longest path length starting from u (excluding u itself, but including edges)
    AdjNode* temp = graph->adjLists[u];
    while (temp != NULL) {
        int v = temp->dest;
        if (v != parent) {
            // This is where the 'special' conditions would be evaluated.
            // Example: if (is_special_connection(u, v, node_values)) {
            //     max_path_len = (max_path_len > (1 + dfs(graph, v, u, dp_memo, node_values))) ? max_path_len : (1 + dfs(graph, v, u, dp_memo, node_values));
            // }
            // Without specific 'special' rules, this calculates the longest simple path.
            max_path_len = (max_path_len > (1 + dfs(graph, v, u, dp_memo, node_values))) ? max_path_len : (1 + dfs(graph, v, u, dp_memo, node_values));
        }
        temp = temp->next;
    }

    dp_memo[u] = max_path_len;
    return max_path_len;
}

int longestSpecialPath(int n, int** edges, int edgesSize, int* edgesColSize, int* node_values) {
    if (n == 0) return 0;

    Graph* graph = createGraph(n);

    // Populate the graph with edges
    for (int i = 0; i < edgesSize; i++) {
        addEdge(graph, edges[i][0], edges[i][1]);
    }

    int max_overall_path = 0;
    int* dp_memo = (int*)malloc(n * sizeof(int));
    if (dp_memo == NULL) {
        // Handle allocation error
        // Free graph memory before exiting
        for (int i = 0; i < n; i++) {
            AdjNode* current = graph->adjLists[i];
            while (current != NULL) {
                AdjNode* next = current->next;
                free(current);
                current = next;
            }
        }
        free(graph->adjLists);
        free(graph);
        exit(EXIT_FAILURE);
    }

    // Iterate through each node as a potential starting point for the longest special path.
    // The 'special' conditions might restrict which nodes can start a path.
    for (int i = 0; i < n; i++) {
        // Reset memoization table for each new starting DFS traversal.
        // This is important if paths can overlap or if the 'special' condition is path-dependent.
        for (int j = 0; j < n; j++) {
            dp_memo[j] = -1;
        }
        int current_path_len = dfs(graph, i, -1, dp_memo, node_values);
        max_overall_path = (max_overall_path > current_path_len) ? max_overall_path : current_path_len;
    }

    // Free allocated memory
    free(dp_memo);
    for (int i = 0; i < n; i++) {
        AdjNode* current = graph->adjLists[i];
        while (current != NULL) {
            AdjNode* next = current->next;
            free(current);
            current = next;
        }
    }
    free(graph->adjLists);
    free(graph);

    return max_overall_path;
}