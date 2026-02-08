#include <stdlib.h>
#include <stdbool.h>

typedef struct AdjListNode {
    int dest;
    struct AdjListNode* next;
} AdjListNode;

void addEdge(AdjListNode** adj, int u, int v) {
    AdjListNode* newNode = (AdjListNode*)malloc(sizeof(AdjListNode));
    newNode->dest = v;
    newNode->next = adj[u];
    adj[u] = newNode;
}

int reachableNodes(int n, int** edges, int edgesSize, int* edgesColSize, int* restrictions, int restrictionsSize) {
    // Initialize adjacency list
    AdjListNode** adj = (AdjListNode**)calloc(n, sizeof(AdjListNode*));
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        addEdge(adj, u, v);
        addEdge(adj, v, u); // Graph is undirected
    }

    // Initialize boolean array for restricted nodes
    bool* is_restricted = (bool*)calloc(n, sizeof(bool));
    for (int i = 0; i < restrictionsSize; i++) {
        is_restricted[restrictions[i]] = true;
    }

    // Initialize boolean array for visited nodes
    bool* visited = (bool*)calloc(n, sizeof(bool));

    // Initialize queue for BFS
    int* queue = (int*)malloc(n * sizeof(int));
    int head = 0;
    int tail = 0; // tail points to the next available slot

    int reachable_count = 0;

    // If node 0 itself is restricted, no nodes are reachable
    if (is_restricted[0]) {
        // Free allocated memory
        for (int i = 0; i < n; i++) {
            AdjListNode* current = adj[i];
            while (current != NULL) {
                AdjListNode* temp = current;
                current = current->next;
                free(temp);
            }
        }
        free(adj);
        free(is_restricted);
        free(visited);
        free(queue);
        return 0;
    }

    // Start BFS from node 0
    queue[tail++] = 0;
    visited[0] = true;
    reachable_count = 1;

    while (head < tail) { // While queue is not empty
        int u = queue[head++];

        AdjListNode* current = adj[u];
        while (current != NULL) {
            int v = current->dest;
            // Visit node v only if it's not restricted and not yet visited
            if (!is_restricted[v] && !visited[v]) {
                visited[v] = true;
                queue[tail++] = v;
                reachable_count++;
            }
            current = current->next;
        }
    }

    // Free all dynamically allocated memory
    for (int i = 0; i < n; i++) {
        AdjListNode* current = adj[i];
        while (current != NULL) {
            AdjListNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(adj);
    free(is_restricted);
    free(visited);
    free(queue);

    return reachable_count;
}