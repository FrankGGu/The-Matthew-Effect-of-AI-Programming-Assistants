#include <stdbool.h>
#include <stdlib.h>

bool isBipartite(int** graph, int graphSize, int* graphColSize) {
    if (graphSize == 0) {
        return true;
    }

    int* colors = (int*)calloc(graphSize, sizeof(int));
    if (colors == NULL) {
        return false;
    }

    int* queue = (int*)malloc(graphSize * sizeof(int));
    if (queue == NULL) {
        free(colors);
        return false;
    }
    int head = 0;
    int tail = 0;

    for (int i = 0; i < graphSize; i++) {
        if (colors[i] == 0) {
            colors[i] = 1;
            queue[tail++] = i;

            while (head < tail) {
                int u = queue[head++];
                int currentColor = colors[u];
                int nextColor = (currentColor == 1) ? 2 : 1;

                for (int j = 0; j < graphColSize[u]; j++) {
                    int v = graph[u][j];

                    if (colors[v] == 0) {
                        colors[v] = nextColor;
                        queue[tail++] = v;
                    } else if (colors[v] == currentColor) {
                        free(colors);
                        free(queue);
                        return false;
                    }
                }
            }
        }
    }

    free(colors);
    free(queue);
    return true;
}