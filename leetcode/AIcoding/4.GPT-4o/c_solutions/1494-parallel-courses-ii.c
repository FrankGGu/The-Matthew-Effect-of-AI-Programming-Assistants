#include <stdio.h>
#include <stdlib.h>

#define MAXN 100

typedef struct {
    int *arr;
    int size;
} List;

int* findOrder(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize, int* returnSize) {
    int *indegree = (int *)calloc(numCourses, sizeof(int));
    List *graph = (List *)malloc(numCourses * sizeof(List));
    for (int i = 0; i < numCourses; i++) {
        graph[i].arr = (int *)malloc(numCourses * sizeof(int));
        graph[i].size = 0;
    }

    for (int i = 0; i < prerequisitesSize; i++) {
        int u = prerequisites[i][1], v = prerequisites[i][0];
        indegree[v]++;
        graph[u].arr[graph[u].size++] = v;
    }

    int *queue = (int *)malloc(numCourses * sizeof(int));
    int front = 0, rear = 0;
    for (int i = 0; i < numCourses; i++) {
        if (indegree[i] == 0) {
            queue[rear++] = i;
        }
    }

    int *courseOrder = (int *)malloc(numCourses * sizeof(int));
    int index = 0;

    while (front < rear) {
        int u = queue[front++];
        courseOrder[index++] = u;
        for (int i = 0; i < graph[u].size; i++) {
            int v = graph[u].arr[i];
            indegree[v]--;
            if (indegree[v] == 0) {
                queue[rear++] = v;
            }
        }
    }

    if (index < numCourses) {
        *returnSize = 0;
        free(courseOrder);
        return NULL;
    }

    *returnSize = numCourses;
    free(indegree);
    for (int i = 0; i < numCourses; i++) {
        free(graph[i].arr);
    }
    free(graph);
    free(queue);
    return courseOrder;
}