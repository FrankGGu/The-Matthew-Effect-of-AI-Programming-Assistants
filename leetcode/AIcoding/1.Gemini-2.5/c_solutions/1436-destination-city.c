#include <string.h>
#include <stdlib.h>

char * destCity(char *** paths, int pathsSize, int* pathsColSize){
    for (int i = 0; i < pathsSize; i++) {
        char *currentCityB = paths[i][1];
        int isDestination = 1;

        for (int j = 0; j < pathsSize; j++) {
            char *currentCityA = paths[j][0];
            if (strcmp(currentCityB, currentCityA) == 0) {
                isDestination = 0;
                break;
            }
        }

        if (isDestination) {
            return strdup(currentCityB);
        }
    }
    return NULL; 
}