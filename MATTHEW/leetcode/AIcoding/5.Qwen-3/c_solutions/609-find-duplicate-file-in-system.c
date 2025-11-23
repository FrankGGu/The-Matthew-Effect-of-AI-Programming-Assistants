#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <stdbool.h>

typedef struct {
    char *key;
    char **value;
    int count;
} HashEntry;

typedef struct {
    HashEntry *entries;
    int size;
} HashMap;

char** findDuplicate(char** paths, int pathsSize, int* returnSize) {
    HashMap map = {NULL, 0};
    for (int i = 0; i < pathsSize; i++) {
        char *path = paths[i];
        char *token = strtok(path, " ");
        while (token != NULL) {
            if (strchr(token, '(')) {
                char *fileContent = strchr(token, '(');
                *fileContent++ = '\0';
                char *content = fileContent;
                char *end = strchr(content, ')');
                if (end) {
                    *end = '\0';
                    bool found = false;
                    for (int j = 0; j < map.size; j++) {
                        if (strcmp(map.entries[j].key, content) == 0) {
                            map.entries[j].count++;
                            map.entries[j].value = realloc(map.entries[j].value, sizeof(char*) * (map.entries[j].count + 1));
                            map.entries[j].value[map.entries[j].count - 1] = strdup(path);
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        map.entries = realloc(map.entries, sizeof(HashEntry) * (map.size + 1));
                        map.entries[map.size].key = strdup(content);
                        map.entries[map.size].value = malloc(sizeof(char*));
                        map.entries[map.size].value[0] = strdup(path);
                        map.entries[map.size].count = 1;
                        map.size++;
                    }
                }
            }
            token = strtok(NULL, " ");
        }
    }

    int resultSize = 0;
    for (int i = 0; i < map.size; i++) {
        if (map.entries[i].count > 1) {
            resultSize += map.entries[i].count;
        }
    }

    char **result = malloc(sizeof(char*) * (resultSize + 1));
    int index = 0;
    for (int i = 0; i < map.size; i++) {
        if (map.entries[i].count > 1) {
            for (int j = 0; j < map.entries[i].count; j++) {
                result[index++] = map.entries[i].value[j];
            }
        }
    }
    *returnSize = resultSize;
    return result;
}