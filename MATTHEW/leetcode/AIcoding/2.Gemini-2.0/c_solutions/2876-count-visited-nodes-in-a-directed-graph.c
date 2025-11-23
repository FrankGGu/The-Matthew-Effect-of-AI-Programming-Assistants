#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* countVisitedNodes(int* edges, int edgesSize) {
    int* result = (int*)malloc(edgesSize * sizeof(int));
    int* visited = (int*)calloc(edgesSize, sizeof(int));
    int* path = (int*)malloc(edgesSize * sizeof(int));
    int* pathLen = (int*)malloc(edgesSize * sizeof(int));
    for (int i = 0; i < edgesSize; i++) {
        result[i] = 0;
    }

    for (int start = 0; start < edgesSize; start++) {
        if (result[start] > 0) continue;

        for (int i = 0; i < edgesSize; i++) {
            visited[i] = 0;
            path[i] = -1;
            pathLen[i] = 0;
        }
        int current = start;
        int len = 0;
        while (visited[current] == 0) {
            visited[current] = 1;
            path[len] = current;
            pathLen[current] = len;
            len++;
            current = edges[current];
        }
        int cycleStart = current;
        int cycleLen = len - pathLen[current];
        for (int i = 0; i < edgesSize; i++) {
            if (pathLen[i] >= 0 && pathLen[i] >= pathLen[cycleStart] && pathLen[i] < pathLen[cycleStart] + cycleLen) {
                result[i] = cycleLen;
            }
        }

        for (int i = 0; i < edgesSize; i++) {
            visited[i] = 0;
        }
        current = start;
        len = 0;
        while (result[current] == 0) {
            result[current] = cycleLen + len + 1;
            current = edges[current];
            len++;
        }
    }

    free(visited);
    free(path);
    free(pathLen);
    return result;
}