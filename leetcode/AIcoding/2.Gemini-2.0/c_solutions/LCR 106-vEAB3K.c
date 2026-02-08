#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isBipartite(int** graph, int graphSize, int* graphColSize){
    int colors[graphSize];
    for (int i = 0; i < graphSize; i++) {
        colors[i] = 0;
    }

    for (int startNode = 0; startNode < graphSize; startNode++) {
        if (colors[startNode] == 0) {
            int queue[graphSize];
            int head = 0, tail = 0;
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
                        return false;
                    }
                }
            }
        }
    }

    return true;
}