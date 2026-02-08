#include <stdbool.h>
#include <stdlib.h>

bool isBipartite(int** graph, int graphSize, int* graphColSize) {
    if (graphSize == 0) {
        return true;
    }

    int* colors = (int*)malloc(graphSize * sizeof(int));
    if (colors == NULL) {
        return false;
    }
    for (int i = 0; i < graphSize; ++i) {
        colors[i] = -1;
    }

    for (int i = 0; i < graphSize; ++i) {
        if (colors[i] == -1) {
            int* queue = (int*)malloc(graphSize * sizeof(int));
            if (queue == NULL) {
                free(colors);
                return false;
            }
            int front = 0;
            int rear = 0;

            queue[rear++] = i;
            colors[i] = 0;

            while (front < rear) {
                int u = queue[front++];
                int currentColor = colors[u];

                for (int j = 0; j < graphColSize[u]; ++j) {
                    int v = graph[u][j];

                    if (colors[v] == -1) {
                        colors[v] = 1 - currentColor;
                        queue[rear++] = v;
                    } else if (colors[v] == currentColor) {
                        free(colors);
                        free(queue);
                        return false;
                    }
                }
            }
            free(queue);
        }
    }

    free(colors);
    return true;
}