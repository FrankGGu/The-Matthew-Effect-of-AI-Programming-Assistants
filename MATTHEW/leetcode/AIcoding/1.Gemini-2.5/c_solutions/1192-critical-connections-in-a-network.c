#include <stdlib.h>
#include <string.h> // For memset, though not used explicitly for visited array
#include <stdio.h>  // For min function, if not using macro

typedef struct AdjNode {
    int neighbor;
    struct AdjNode* next;
} AdjNode;

typedef struct {
    AdjNode* head;
} AdjList;

AdjList* graph;
int* disc; // Discovery time
int* low;  // Low-link value
int* visited; // 0 for not visited, 1 for visited
int timer;
int** bridges_result; // Stores the found bridges
int bridges_count;
int bridges_capacity;
int N_nodes; // Total number of nodes

int min(int a, int b) {
    return (a < b) ? a : b;
}

void addEdge(int u, int v) {
    AdjNode* newNode = (AdjNode*)malloc(sizeof(AdjNode));
    newNode->neighbor = v;
    newNode->next = graph[u].head;
    graph[u].head = newNode;
}

void dfs(int u, int parent) {
    visited[u] = 1;
    disc[u] = low[u] = timer++;

    AdjNode* current = graph[u].head;
    while (current != NULL) {
        int v = current->neighbor;

        // If v is the parent of u, skip this edge (don't go back up the DFS tree)
        if (v == parent) {
            current = current->next;
            continue;
        }

        // If v is already visited
        if (visited[v]) {
            // This is a back-edge to an ancestor
            low[u] = min(low[u], disc[v]);
        } else {
            // This is a tree-edge, recurse on v
            dfs(v, u);

            // After recursion, update low[u] based on low[v]
            low[u] = min(low[u], low[v]);

            // If low[v] > disc[u], then (u, v) is a bridge
            if (low[v] > disc[u]) {
                if (bridges_count == bridges_capacity) {
                    bridges_capacity *= 2;
                    bridges_result = (int**)realloc(bridges_result, bridges_capacity * sizeof(int*));
                }
                bridges_result[bridges_count] = (int*)malloc(2 * sizeof(int));
                bridges_result[bridges_count][0] = u;
                bridges_result[bridges_count][1] = v;
                bridges_count++;
            }
        }
        current = current->next;
    }
}

int** criticalConnections(int n, int** connections, int connectionsSize, int* connectionsColSize, int* returnSize, int** returnColumnSizes) {
    N_nodes = n;

    // Initialize graph adjacency list
    graph = (AdjList*)malloc(n * sizeof(AdjList));
    for (int i = 0; i < n; i++) {
        graph[i].head = NULL;
    }

    // Build the graph by adding edges
    for (int i = 0; i < connectionsSize; i++) {
        int u = connections[i][0];
        int v = connections[i][1];
        addEdge(u, v);
        addEdge(v, u); // Graph is undirected
    }

    // Initialize DFS related arrays
    disc = (int*)malloc(n * sizeof(int));
    low = (int*)malloc(n * sizeof(int));
    visited = (int*)calloc(n, sizeof(int)); // calloc initializes to 0
    timer = 0;

    // Initialize result array for bridges
    bridges_capacity = connectionsSize > 0 ? connectionsSize : 1; // Max possible bridges is connectionsSize
    bridges_result = (int**)malloc(bridges_capacity * sizeof(int*));
    bridges_count = 0;

    // Run DFS from all unvisited nodes to handle disconnected components
    // (Although problem states graph is connected, this makes the solution robust)
    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            dfs(i, -1); // -1 indicates no parent for the root of DFS tree
        }
    }

    // Prepare return values for LeetCode
    *returnSize = bridges_count;
    *returnColumnSizes = (int*)malloc(bridges_count * sizeof(int));
    for (int i = 0; i < bridges_count; i++) {
        (*returnColumnSizes)[i] = 2; // Each bridge is an array of 2 integers
    }

    // Free dynamically allocated temporary memory
    free(disc);
    free(low);
    free(visited);

    // Free adjacency list nodes
    for (int i = 0; i < n; i++) {
        AdjNode* current = graph[i].head;
        while (current != NULL) {
            AdjNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(graph);

    return bridges_result;
}