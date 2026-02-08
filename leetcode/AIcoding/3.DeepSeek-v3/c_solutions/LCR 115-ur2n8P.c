#include <stdlib.h>
#include <stdbool.h>

bool sequenceReconstruction(int* nums, int numsSize, int** sequences, int sequencesSize, int* sequencesColSize) {
    int n = numsSize;
    int* indegree = (int*)calloc(n + 1, sizeof(int));
    int* graph = (int*)calloc((n + 1) * (n + 1), sizeof(int));

    for (int i = 0; i < sequencesSize; i++) {
        for (int j = 0; j < sequencesColSize[i] - 1; j++) {
            int u = sequences[i][j];
            int v = sequences[i][j + 1];
            if (graph[u * (n + 1) + v] == 0) {
                graph[u * (n + 1) + v] = 1;
                indegree[v]++;
            }
        }
    }

    int* queue = (int*)malloc(n * sizeof(int));
    int front = 0, rear = 0;

    for (int i = 1; i <= n; i++) {
        if (indegree[i] == 0) {
            queue[rear++] = i;
        }
    }

    int index = 0;
    while (front < rear) {
        if (rear - front > 1) {
            free(indegree);
            free(graph);
            free(queue);
            return false;
        }

        int u = queue[front++];
        if (u != nums[index++]) {
            free(indegree);
            free(graph);
            free(queue);
            return false;
        }

        for (int v = 1; v <= n; v++) {
            if (graph[u * (n + 1) + v] == 1) {
                indegree[v]--;
                if (indegree[v] == 0) {
                    queue[rear++] = v;
                }
            }
        }
    }

    free(indegree);
    free(graph);
    free(queue);
    return index == n;
}