#include <stdio.h>
#include <stdlib.h>

int* findOrder(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize, int* returnSize) {
    int* indegree = (int*)calloc(numCourses, sizeof(int));
    int** graph = (int**)malloc(numCourses * sizeof(int*));
    for (int i = 0; i < numCourses; i++) {
        graph[i] = (int*)malloc(numCourses * sizeof(int));
        for (int j = 0; j < numCourses; j++) {
            graph[i][j] = 0;
        }
    }

    for (int i = 0; i < prerequisitesSize; i++) {
        int u = prerequisites[i][1];
        int v = prerequisites[i][0];
        graph[u][v] = 1;
        indegree[v]++;
    }

    int* order = (int*)malloc(numCourses * sizeof(int));
    int front = 0, rear = 0;
    int* queue = (int*)malloc(numCourses * sizeof(int));

    for (int i = 0; i < numCourses; i++) {
        if (indegree[i] == 0) {
            queue[rear++] = i;
        }
    }

    while (front < rear) {
        int u = queue[front++];
        order[(*returnSize)++] = u;
        for (int v = 0; v < numCourses; v++) {
            if (graph[u][v]) {
                indegree[v]--;
                if (indegree[v] == 0) {
                    queue[rear++] = v;
                }
            }
        }
    }

    for (int i = 0; i < numCourses; i++) {
        free(graph[i]);
    }
    free(graph);
    free(indegree);
    free(queue);

    if (*returnSize < numCourses) {
        free(order);
        *returnSize = 0;
        return NULL;
    }

    return order;
}