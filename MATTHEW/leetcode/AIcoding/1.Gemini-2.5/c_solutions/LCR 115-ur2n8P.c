#include <stdbool.h>
#include <stdlib.h>
#include <string.h> // For memset (though calloc handles zeroing)

typedef struct Edge {
    int to;
    struct Edge* next;
} Edge;

void freeAdjList(Edge** adj, int n) {
    if (!adj) return;
    for (int i = 0; i <= n; ++i) {
        Edge* current = adj[i];
        while (current != NULL) {
            Edge* next = current->next;
            free(current);
            current = next;
        }
    }
    free(adj);
}

bool sequenceReconstruction(int* org, int orgSize, int** seqs, int seqsSize, int* seqsColSize) {
    if (orgSize == 0) {
        return true; // An empty sequence is always uniquely reconstructed.
    }

    int n = orgSize;

    // Allocate memory for in-degrees, adjacency list, and presence tracking
    int* inDegree = (int*)calloc(n + 1, sizeof(int));
    Edge** adj = (Edge**)calloc(n + 1, sizeof(Edge*)); // Array of pointers to Edge structs
    bool* present = (bool*)calloc(n + 1, sizeof(bool)); // To check if all org elements appear in seqs

    if (!inDegree || !adj || !present) {
        // Handle memory allocation failure
        free(inDegree);
        freeAdjList(adj, 0); // Pass 0 as n since adj might be partially allocated or not at all
        free(present);
        return false;
    }

    // Build the graph and calculate in-degrees
    for (int i = 0; i < seqsSize; ++i) {
        int* seq = seqs[i];
        int seqLen = seqsColSize[i];

        for (int j = 0; j < seqLen; ++j) {
            int num = seq[j];
            // Check if the number is within the valid range [1, n]
            if (num < 1 || num > n) {
                freeAdjList(adj, n);
                free(inDegree);
                free(present);
                return false; // Invalid number in sequence
            }
            present[num] = true;

            if (j + 1 < seqLen) {
                int u = seq[j];
                int v = seq[j+1];

                // Add edge u -> v
                Edge* newEdge = (Edge*)malloc(sizeof(Edge));
                if (!newEdge) {
                    // Handle memory allocation failure
                    freeAdjList(adj, n);
                    free(inDegree);
                    free(present);
                    return false;
                }
                newEdge->to = v;
                newEdge->next = adj[u];
                adj[u] = newEdge;
                inDegree[v]++;
            }
        }
    }

    // Check if all numbers from 1 to n (present in org) appeared in any of the sequences
    for (int i = 1; i <= n; ++i) {
        if (!present[i]) {
            freeAdjList(adj, n);
            free(inDegree);
            free(present);
            return false; // An element from org is missing in seqs
        }
    }

    // Topological Sort (Kahn's algorithm)
    int* queue = (int*)malloc((n + 1) * sizeof(int));
    if (!queue) {
        freeAdjList(adj, n);
        free(inDegree);
        free(present);
        return false; // Handle memory allocation failure
    }
    int front = 0, rear = 0;

    for (int i = 1; i <= n; ++i) {
        if (inDegree[i] == 0) {
            queue[rear++] = i;
        }
    }

    int* reconstructedSeq = (int*)malloc(n * sizeof(int));
    if (!reconstructedSeq) {
        freeAdjList(adj, n);
        free(inDegree);
        free(present);
        free(queue);
        return false; // Handle memory allocation failure
    }
    int reconstructedIdx = 0;

    while (front < rear) {
        if (rear - front > 1) {
            // More than one node with in-degree 0, so reconstruction is not unique
            freeAdjList(adj, n);
            free(inDegree);
            free(present);
            free(queue);
            free(reconstructedSeq);
            return false;
        }

        int u = queue[front++];
        reconstructedSeq[reconstructedIdx++] = u;

        Edge* current = adj[u];
        while (current != NULL) {
            int v = current->to;
            inDegree[v]--;
            if (inDegree[v] == 0) {
                queue[rear++] = v;
            }
            current = current->next;
        }
    }

    // Final checks
    bool result = true;
    if (reconstructedIdx != n) {
        result = false; // Not all elements were processed (e.g., cycle or disconnected graph)
    } else {
        for (int i = 0; i < n; ++i) {
            if (reconstructedSeq[i] != org[i]) {
                result = false; // Reconstructed sequence does not match org
                break;
            }
        }
    }

    // Free all allocated memory
    freeAdjList(adj, n);
    free(inDegree);
    free(present);
    free(queue);
    free(reconstructedSeq);

    return result;
}