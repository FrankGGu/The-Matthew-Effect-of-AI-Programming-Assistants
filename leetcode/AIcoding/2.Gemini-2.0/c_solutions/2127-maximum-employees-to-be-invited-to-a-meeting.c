#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumInvitations(int* favorite, int favoriteSize) {
    int* inDegree = (int*)malloc(sizeof(int) * favoriteSize);
    for (int i = 0; i < favoriteSize; i++) {
        inDegree[i] = 0;
    }
    for (int i = 0; i < favoriteSize; i++) {
        inDegree[favorite[i]]++;
    }

    int* queue = (int*)malloc(sizeof(int) * favoriteSize);
    int head = 0, tail = 0;
    int* depth = (int*)malloc(sizeof(int) * favoriteSize);
    for (int i = 0; i < favoriteSize; i++) {
        depth[i] = 1;
    }

    for (int i = 0; i < favoriteSize; i++) {
        if (inDegree[i] == 0) {
            queue[tail++] = i;
        }
    }

    while (head < tail) {
        int u = queue[head++];
        int v = favorite[u];
        depth[v] = fmax(depth[v], depth[u] + 1);
        inDegree[v]--;
        if (inDegree[v] == 0) {
            queue[tail++] = v;
        }
    }

    int cycleSum = 0;
    int maxRingSize = 0;
    int* visited = (int*)malloc(sizeof(int) * favoriteSize);
    for (int i = 0; i < favoriteSize; i++) {
        visited[i] = 0;
    }

    for (int i = 0; i < favoriteSize; i++) {
        if (visited[i]) continue;
        if (favorite[favorite[i]] == i) {
            cycleSum += depth[i] + depth[favorite[i]];
            visited[i] = visited[favorite[i]] = 1;
        }
    }

    for (int i = 0; i < favoriteSize; i++) {
        int count = 0;
        int current = i;
        while(visited[current] == 0) {
            count++;
            visited[current] = 1;
            current = favorite[current];
        }
        if(favorite[favorite[i]] == i) continue;

        int cycleLength = 0;
        int start = i;
        while(1) {
            cycleLength++;
            start = favorite[start];
            if(start == i) break;
        }
        maxRingSize = fmax(maxRingSize, cycleLength);

    }

    maxRingSize = fmax(maxRingSize, 0);

    free(inDegree);
    free(queue);
    free(depth);
    free(visited);

    return fmax(cycleSum, maxRingSize);
}