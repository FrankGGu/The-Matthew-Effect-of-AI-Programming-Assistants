#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* destCity(char*** paths, int pathsSize, int* returnSize) {
    char** startCities = (char**)malloc(pathsSize * sizeof(char*));
    char** endCities = (char**)malloc(pathsSize * sizeof(char*));

    for (int i = 0; i < pathsSize; i++) {
        startCities[i] = paths[i][0];
        endCities[i] = paths[i][1];
    }

    for (int i = 0; i < pathsSize; i++) {
        int found = 0;
        for (int j = 0; j < pathsSize; j++) {
            if (strcmp(endCities[i], startCities[j]) == 0) {
                found = 1;
                break;
            }
        }
        if (!found) {
            *returnSize = 1;
            return endCities[i];
        }
    }

    *returnSize = 0;
    return NULL;
}