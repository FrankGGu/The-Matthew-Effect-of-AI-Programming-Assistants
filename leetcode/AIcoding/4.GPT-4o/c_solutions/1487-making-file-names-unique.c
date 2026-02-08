#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **getFolderNames(char **names, int namesSize, int *returnSize) {
    char **result = (char **)malloc(namesSize * sizeof(char *));
    int *count = (int *)calloc(namesSize, sizeof(int));
    int index = 0;
    *returnSize = 0;

    for (int i = 0; i < namesSize; i++) {
        char *name = names[i];
        if (count[i] == 0) {
            result[index++] = strdup(name);
            *returnSize += 1;
        } else {
            char *newName = (char *)malloc(100);
            while (1) {
                sprintf(newName, "%s(%d)", name, count[i]);
                int j;
                for (j = 0; j < *returnSize; j++) {
                    if (strcmp(result[j], newName) == 0) {
                        break;
                    }
                }
                if (j == *returnSize) {
                    result[index++] = newName;
                    count[i]++;
                    *returnSize += 1;
                    break;
                }
                count[i]++;
            }
            free(newName);
        }
        for (int j = 0; j < i; j++) {
            if (strcmp(names[j], name) == 0) {
                count[i]++;
            }
        }
    }

    return result;
}