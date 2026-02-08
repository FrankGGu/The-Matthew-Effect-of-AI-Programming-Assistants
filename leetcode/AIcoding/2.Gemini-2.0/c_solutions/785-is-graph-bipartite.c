#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isBipartite(int** graph, int graphSize, int* graphColSize) {
    int* colors = (int*)malloc(sizeof(int) * graphSize);
    for (int i = 0; i < graphSize; i++) {
        colors[i] = 0;
    }

    for (int startNode = 0; startNode < graphSize; startNode++) {
        if (colors[startNode] == 0) {
            int* queue = (int*)malloc(sizeof(int) * graphSize);
            int head = 0;
            int tail = 0;

            queue[tail++] = startNode;
            colors[startNode] = 1;

            while (head < tail) {
                int u = queue[head++];

                for (int i = 0; i < graphColSize[u]; i++) {
                    int v = graph[u][i];

                    if (colors[v] == 0) {
                        colors[v] = -colors[u];
                        queue[tail++] = v;
                    } else if (colors[v] == colors[u]) {
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