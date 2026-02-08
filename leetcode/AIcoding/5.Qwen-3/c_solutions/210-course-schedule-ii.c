#include <stdio.h>
#include <stdlib.h>

int* findOrder(int numCourses, int** prerequisites, int prerequisitesSize, int* returnSize) {
    int* inDegree = (int*)calloc(numCourses, sizeof(int));
    int** adj = (int**)malloc(numCourses * sizeof(int*));
    for (int i = 0; i < numCourses; i++) {
        adj[i] = (int*)malloc(0);
    }

    for (int i = 0; i < prerequisitesSize; i++) {
        int course = prerequisites[i][0];
        int prereq = prerequisites[i][1];
        adj[prereq][inDegree[prereq]++] = course;
    }

    int* queue = (int*)malloc(numCourses * sizeof(int));
    int front = 0, rear = 0;
    for (int i = 0; i < numCourses; i++) {
        if (inDegree[i] == 0) {
            queue[rear++] = i;
        }
    }

    int* result = (int*)malloc(numCourses * sizeof(int));
    int count = 0;

    while (front < rear) {
        int current = queue[front++];
        result[count++] = current;

        for (int i = 0; i < inDegree[current]; i++) {
            int neighbor = adj[current][i];
            inDegree[neighbor]--;
            if (inDegree[neighbor] == 0) {
                queue[rear++] = neighbor;
            }
        }
    }

    if (count != numCourses) {
        *returnSize = 0;
        free(result);
        return NULL;
    }

    *returnSize = numCourses;
    return result;
}