#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool* pathQueries(int n, int** edges, int edgesSize, int* edgesColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    bool* result = (bool*)malloc(queriesSize * sizeof(bool));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int start = queries[i][0];
        int end = queries[i][1];
        bool found = false;

        bool* visited = (bool*)calloc(n, sizeof(bool));
        int* queue = (int*)malloc(n * sizeof(int));
        int front = 0;
        int rear = 0;

        queue[rear++] = start;
        visited[start] = true;

        while (front < rear) {
            int current = queue[front++];

            if (current == end) {
                found = true;
                break;
            }

            for (int j = 0; j < edgesSize; j++) {
                if (edges[j][0] == current && !visited[edges[j][1]]) {
                    queue[rear++] = edges[j][1];
                    visited[edges[j][1]] = true;
                } else if (edges[j][1] == current && !visited[edges[j][0]]) {
                    queue[rear++] = edges[j][0];
                    visited[edges[j][0]] = true;
                }
            }
        }

        result[i] = found;
        free(visited);
        free(queue);
    }

    return result;
}