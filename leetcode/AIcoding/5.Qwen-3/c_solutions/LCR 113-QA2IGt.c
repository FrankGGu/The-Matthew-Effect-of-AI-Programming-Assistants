#include <stdio.h>
#include <stdlib.h>

int* findOrder(int numCourses, int** prerequisites, int prerequisitesSize, int* returnSize) {
    int* inDegree = (int*)malloc(numCourses * sizeof(int));
    int* result = (int*)malloc(numCourses * sizeof(int));
    int index = 0;

    for (int i = 0; i < numCourses; i++) {
        inDegree[i] = 0;
    }

    int** graph = (int**)malloc(numCourses * sizeof(int*));
    for (int i = 0; i < numCourses; i++) {
        graph[i] = (int*)malloc(numCourses * sizeof(int));
        for (int j = 0; j < numCourses; j++) {
            graph[i][j] = 0;
        }
    }

    for (int i = 0; i < prerequisitesSize; i++) {
        int course = prerequisites[i][0];
        int pre = prerequisites[i][1];
        graph[pre][course] = 1;
        inDegree[course]++;
    }

    int* queue = (int*)malloc(numCourses * sizeof(int));
    int front = 0, rear = 0;

    for (int i = 0; i < numCourses; i++) {
        if (inDegree[i] == 0) {
            queue[rear++] = i;
        }
    }

    while (front < rear) {
        int current = queue[front++];
        result[index++] = current;

        for (int i = 0; i < numCourses; i++) {
            if (graph[current][i] == 1) {
                inDegree[i]--;
                if (inDegree[i] == 0) {
                    queue[rear++] = i;
                }
            }
        }
    }

    if (index != numCourses) {
        *returnSize = 0;
        free(result);
        return NULL;
    }

    *returnSize = numCourses;
    return result;
}