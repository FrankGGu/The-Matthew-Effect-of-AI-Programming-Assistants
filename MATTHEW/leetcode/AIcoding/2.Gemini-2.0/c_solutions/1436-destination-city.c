#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * destCity(char *** paths, int pathsSize, int* pathsColSize){
    int i, j;
    int max_len = 0;
    for (i = 0; i < pathsSize; i++) {
        for (j = 0; j < pathsColSize[i]; j++) {
            int len = strlen(paths[i][j]);
            if (len > max_len) {
                max_len = len;
            }
        }
    }

    char* dest = malloc((max_len + 1) * sizeof(char));
    if (dest == NULL) {
        return NULL;
    }

    strcpy(dest, paths[0][1]);

    int found;
    for(i = 0; i < pathsSize; i++){
        found = 0;
        for(j = 0; j < pathsSize; j++){
            if(strcmp(paths[j][0], dest) == 0){
                found = 1;
                break;
            }
        }
        if(found == 0){
            return dest;
        }
        strcpy(dest, paths[i][1]);
    }

    for(i = 0; i < pathsSize; i++){
        found = 0;
        for(j = 0; j < pathsSize; j++){
            if(strcmp(paths[j][0], paths[i][1]) == 0){
                found = 1;
                break;
            }
        }
        if(found == 0){
            return paths[i][1];
        }
    }

    return dest;
}