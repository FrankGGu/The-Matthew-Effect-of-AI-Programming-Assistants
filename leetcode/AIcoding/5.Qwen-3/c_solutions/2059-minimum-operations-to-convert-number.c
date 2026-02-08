#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int minimumOperationsToConvertNumber(int nums, int start, int goal) {
    int* visited = (int*)malloc(sizeof(int) * 1001);
    for (int i = 0; i <= 1000; i++) {
        visited[i] = -1;
    }

    int queue[1001];
    int front = 0, rear = 0;

    queue[rear++] = start;
    visited[start] = 0;

    while (front < rear) {
        int current = queue[front++];
        if (current == goal) {
            return visited[current];
        }

        for (int i = 0; i < nums; i++) {
            int next = current ^ (1 << i);
            if (next >= 0 && next <= 1000 && visited[next] == -1) {
                visited[next] = visited[current] + 1;
                queue[rear++] = next;
            }
        }
    }

    return -1;
}