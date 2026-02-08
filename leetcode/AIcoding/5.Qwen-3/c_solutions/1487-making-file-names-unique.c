#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *name;
    int count;
} NameCount;

char** getFolderNames(char** names, int namesSize, int* returnSize) {
    int capacity = 10;
    char **result = (char **)malloc(capacity * sizeof(char *));
    NameCount *map = (NameCount *)malloc(capacity * sizeof(NameCount));
    int mapSize = 0;
    int index = 0;

    for (int i = 0; i < namesSize; i++) {
        char *name = names[i];
        int found = 0;
        for (int j = 0; j < mapSize; j++) {
            if (strcmp(map[j].name, name) == 0) {
                found = 1;
                map[j].count++;
                char *newName = (char *)malloc(200 * sizeof(char));
                sprintf(newName, "%s(%d)", name, map[j].count);
                result[index++] = newName;
                if (index >= capacity) {
                    capacity *= 2;
                    result = (char **)realloc(result, capacity * sizeof(char *));
                }
                break;
            }
        }
        if (!found) {
            result[index++] = strdup(name);
            NameCount nc;
            nc.name = strdup(name);
            nc.count = 1;
            if (mapSize >= capacity) {
                capacity *= 2;
                map = (NameCount *)realloc(map, capacity * sizeof(NameCount));
            }
            map[mapSize++] = nc;
        }
    }

    *returnSize = index;
    return result;
}