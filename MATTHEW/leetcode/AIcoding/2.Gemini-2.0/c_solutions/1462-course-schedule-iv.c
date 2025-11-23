#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool* checkIfPrerequisite(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int i, j, k;
    bool* result = (bool*)malloc(sizeof(bool) * queriesSize);
    *returnSize = queriesSize;

    bool adjMatrix[numCourses][numCourses];
    for (i = 0; i < numCourses; i++) {
        for (j = 0; j < numCourses; j++) {
            adjMatrix[i][j] = false;
        }
    }

    for (i = 0; i < prerequisitesSize; i++) {
        adjMatrix[prerequisites[i][0]][prerequisites[i][1]] = true;
    }

    for (k = 0; k < numCourses; k++) {
        for (i = 0; i < numCourses; i++) {
            for (j = 0; j < numCourses; j++) {
                adjMatrix[i][j] = adjMatrix[i][j] || (adjMatrix[i][k] && adjMatrix[k][j]);
            }
        }
    }

    for (i = 0; i < queriesSize; i++) {
        result[i] = adjMatrix[queries[i][0]][queries[i][1]];
    }

    return result;
}