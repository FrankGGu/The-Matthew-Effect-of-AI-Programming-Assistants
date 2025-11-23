#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ** getFolderNames(char ** names, int namesSize, int* returnSize){
    char ** result = (char **)malloc(sizeof(char *) * namesSize);
    *returnSize = namesSize;

    char ** used = (char **)malloc(sizeof(char *) * namesSize);
    int usedSize = 0;

    for (int i = 0; i < namesSize; i++) {
        char * currentName = names[i];
        int found = 0;
        for (int j = 0; j < usedSize; j++) {
            if (strcmp(currentName, used[j]) == 0) {
                found = 1;
                break;
            }
        }

        if (!found) {
            result[i] = strdup(currentName);
            used[usedSize++] = strdup(currentName);
        } else {
            int k = 1;
            char * newName = (char *)malloc(sizeof(char) * 201);
            while (1) {
                sprintf(newName, "%s(%d)", currentName, k);
                int newFound = 0;
                for (int j = 0; j < usedSize; j++) {
                    if (strcmp(newName, used[j]) == 0) {
                        newFound = 1;
                        break;
                    }
                }
                if (!newFound) {
                    result[i] = strdup(newName);
                    used[usedSize++] = strdup(newName);
                    free(newName);
                    break;
                }
                k++;
            }
        }
    }

    for(int i = 0; i < usedSize; i++) {
        free(used[i]);
    }
    free(used);

    return result;
}