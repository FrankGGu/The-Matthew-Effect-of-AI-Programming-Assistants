#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* neighbors;
    int size;
} AdjList;

int countComponents(int n, int** edges, int edgesSize, int* edgesColSize) {
    AdjList* adj = (AdjList*)malloc(n * sizeof(AdjList));
    for (int i = 0; i < n; i++) {
        adj[i].neighbors = NULL;
        adj[i].size = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int* newNeighbors = (int*)realloc(adj[u].neighbors, (adj[u].size + 1) * sizeof(int));
        newNeighbors[adj[u].size++] = v;
        adj[u].neighbors = newNeighbors;

        newNeighbors = (int*)realloc(adj[v].neighbors, (adj[v].size + 1) * sizeof(int));
        newNeighbors[adj[v].size++] = u;
        adj[v].neighbors = newNeighbors;
    }

    int* visited = (int*)calloc(n, sizeof(int));
    int count = 0;

    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            int* stack = (int*)malloc(n * sizeof(int));
            int top = -1;
            stack[++top] = i;
            visited[i] = 1;
            int componentSize = 0;
            int isComplete = 1;

            while (top >= 0) {
                int node = stack[top--];
                componentSize++;

                for (int j = 0; j < adj[node].size; j++) {
                    int neighbor = adj[node].neighbors[j];
                    if (!visited[neighbor]) {
                        visited[neighbor] = 1;
                        stack[++top] = neighbor;
                    }
                }
            }

            for (int j = 0; j < n; j++) {
                if (visited[j]) {
                    int degree = 0;
                    for (int k = 0; k < adj[j].size; k++) {
                        if (visited[adj[j].neighbors[k]]) {
                            degree++;
                        }
                    }
                    if (degree != componentSize - 1) {
                        isComplete = 0;
                        break;
                    }
                }
            }

            if (isComplete) {
                count++;
            }

            free(stack);
        }
    }

    for (int i = 0; i < n; i++) {
        free(adj[i].neighbors);
    }
    free(adj);
    free(visited);

    return count;
}