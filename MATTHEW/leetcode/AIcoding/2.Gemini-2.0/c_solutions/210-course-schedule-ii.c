#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findOrder(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize, int* returnSize) {
    int* inDegree = (int*)malloc(sizeof(int) * numCourses);
    int* result = (int*)malloc(sizeof(int) * numCourses);
    int resultIndex = 0;

    for (int i = 0; i < numCourses; i++) {
        inDegree[i] = 0;
    }

    for (int i = 0; i < prerequisitesSize; i++) {
        inDegree[prerequisites[i][0]]++;
    }

    int* queue = (int*)malloc(sizeof(int) * numCourses);
    int head = 0, tail = 0;

    for (int i = 0; i < numCourses; i++) {
        if (inDegree[i] == 0) {
            queue[tail++] = i;
        }
    }

    while (head < tail) {
        int course = queue[head++];
        result[resultIndex++] = course;

        for (int i = 0; i < prerequisitesSize; i++) {
            if (prerequisites[i][1] == course) {
                inDegree[prerequisites[i][0]]--;
                if (inDegree[prerequisites[i][0]] == 0) {
                    queue[tail++] = prerequisites[i][0];
                }
            }
        }
    }

    free(queue);

    if (resultIndex == numCourses) {
        *returnSize = numCourses;
        return result;
    } else {
        *returnSize = 0;
        free(result);
        return NULL;
    }
}