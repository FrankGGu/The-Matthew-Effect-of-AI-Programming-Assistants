#include <stdio.h>
#include <stdlib.h>

bool possibleBipartition(int n, int** dislikes, int dislikesSize, int* dislikesColSize) {
    int* color = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        color[i] = -1;
    }

    int** graph = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc(0);
    }

    for (int i = 0; i < dislikesSize; i++) {
        int u = dislikes[i][0] - 1;
        int v = dislikes[i][1] - 1;
        int* temp = (int*)realloc(graph[u], (sizeof(int) * (sizeof(graph[u]) / sizeof(int) + 1)));
        temp[sizeof(temp) / sizeof(int) - 1] = v;
        graph[u] = temp;

        temp = (int*)realloc(graph[v], (sizeof(int) * (sizeof(graph[v]) / sizeof(int) + 1)));
        temp[sizeof(temp) / sizeof(int) - 1] = u;
        graph[v] = temp;
    }

    for (int i = 0; i < n; i++) {
        if (color[i] == -1) {
            int* queue = (int*)malloc(n * sizeof(int));
            int front = 0, rear = 0;
            queue[rear++] = i;
            color[i] = 0;

            while (front < rear) {
                int current = queue[front++];
                for (int j = 0; j < sizeof(graph[current]) / sizeof(int); j++) {
                    int neighbor = graph[current][j];
                    if (color[neighbor] == -1) {
                        color[neighbor] = color[current] ^ 1;
                        queue[rear++] = neighbor;
                    } else if (color[neighbor] == color[current]) {
                        free(color);
                        for (int k = 0; k < n; k++) {
                            free(graph[k]);
                        }
                        free(graph);
                        free(queue);
                        return false;
                    }
                }
            }
            free(queue);
        }
    }

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(color);
    return true;
}