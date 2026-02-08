#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findOrder(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize, int* returnSize) {
    int* inDegree = (int*)malloc(sizeof(int) * numCourses);
    memset(inDegree, 0, sizeof(int) * numCourses);

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

    int* result = (int*)malloc(sizeof(int) * numCourses);
    int index = 0;

    while (head < tail) {
        int course = queue[head++];
        result[index++] = course;

        for (int i = 0; i < prerequisitesSize; i++) {
            if (prerequisites[i][1] == course) {
                inDegree[prerequisites[i][0]]--;
                if (inDegree[prerequisites[i][0]] == 0) {
                    queue[tail++] = prerequisites[i][0];
                }
            }
        }
    }

    if (index == numCourses) {
        *returnSize = numCourses;
        return result;
    } else {
        *returnSize = 0;
        free(result);
        return NULL;
    }
}

int** buildMatrix(int k, int** rowConditions, int rowConditionsSize, int* rowConditionsColSize, int** colConditions, int colConditionsSize, int* colConditionsColSize, int* returnSize, int** returnColumnSizes) {
    int* rowOrder;
    int rowOrderSize;
    rowOrder = findOrder(k, rowConditions, rowConditionsSize, rowConditionsColSize, &rowOrderSize);

    int* colOrder;
    int colOrderSize;
    colOrder = findOrder(k, colConditions, colConditionsSize, colConditionsColSize, &colOrderSize);

    if (rowOrderSize != k || colOrderSize != k) {
        *returnSize = 0;
        return NULL;
    }

    int** matrix = (int**)malloc(sizeof(int*) * k);
    *returnColumnSizes = (int*)malloc(sizeof(int) * k);
    for (int i = 0; i < k; i++) {
        matrix[i] = (int*)malloc(sizeof(int) * k);
        (*returnColumnSizes)[i] = k;
        for (int j = 0; j < k; j++) {
            matrix[i][j] = 0;
        }
    }

    for (int i = 0; i < k; i++) {
        matrix[rowOrder[i]][colOrder[i]] = i + 1;
    }

    free(rowOrder);
    free(colOrder);

    *returnSize = k;
    return matrix;
}