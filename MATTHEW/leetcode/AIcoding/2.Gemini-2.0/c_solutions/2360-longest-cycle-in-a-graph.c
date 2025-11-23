#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestCycle(int* edges, int edgesSize) {
    int n = edgesSize;
    int maxCycle = -1;
    int* visited = (int*)malloc(sizeof(int) * n);
    int* path = (int*)malloc(sizeof(int) * n);
    for (int i = 0; i < n; i++) {
        visited[i] = 0;
        path[i] = 0;
    }

    for (int startNode = 0; startNode < n; startNode++) {
        if (visited[startNode] == 0) {
            int currNode = startNode;
            int pathLength = 1;
            path[currNode] = pathLength;
            visited[currNode] = 1;

            while (edges[currNode] != -1 && visited[edges[currNode]] != 1) {
                currNode = edges[currNode];
                pathLength++;
                path[currNode] = pathLength;
                visited[currNode] = 1;
            }

            if (edges[currNode] != -1 && visited[edges[currNode]] == 1) {
                if (path[edges[currNode]] > 0) {
                    int cycleLength = path[currNode] - path[edges[currNode]] + 1;
                    if (cycleLength > maxCycle) {
                        maxCycle = cycleLength;
                    }
                }
            }

            for(int i = 0; i < n; i++){
                if(visited[i] == 1){
                    path[i] = 0;
                    visited[i] = 2;
                }
            }
        }
    }

    free(visited);
    free(path);
    return maxCycle;
}