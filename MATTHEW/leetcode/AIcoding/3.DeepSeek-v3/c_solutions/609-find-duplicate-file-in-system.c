/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the return arrays are stored in *returnColumnSizes.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
typedef struct {
    char* key;
    char** paths;
    int count;
    int capacity;
} FileGroup;

typedef struct {
    FileGroup* groups;
    int size;
    int capacity;
} HashMap;

HashMap* createHashMap(int capacity) {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    map->groups = (FileGroup*)malloc(capacity * sizeof(FileGroup));
    map->size = 0;
    map->capacity = capacity;
    return map;
}

void addToHashMap(HashMap* map, char* content, char* path) {
    for (int i = 0; i < map->size; i++) {
        if (strcmp(map->groups[i].key, content) == 0) {
            if (map->groups[i].count >= map->groups[i].capacity) {
                map->groups[i].capacity *= 2;
                map->groups[i].paths = (char**)realloc(map->groups[i].paths, map->groups[i].capacity * sizeof(char*));
            }
            map->groups[i].paths[map->groups[i].count++] = path;
            return;
        }
    }

    if (map->size >= map->capacity) {
        map->capacity *= 2;
        map->groups = (FileGroup*)realloc(map->groups, map->capacity * sizeof(FileGroup));
    }

    map->groups[map->size].key = (char*)malloc((strlen(content) + 1) * sizeof(char));
    strcpy(map->groups[map->size].key, content);
    map->groups[map->size].capacity = 4;
    map->groups[map->size].count = 0;
    map->groups[map->size].paths = (char**)malloc(map->groups[map->size].capacity * sizeof(char*));
    map->groups[map->size].paths[map->groups[map->size].count++] = path;
    map->size++;
}

void freeHashMap(HashMap* map) {
    for (int i = 0; i < map->size; i++) {
        free(map->groups[i].key);
        free(map->groups[i].paths);
    }
    free(map->groups);
    free(map);
}

char*** findDuplicate(char** paths, int pathsSize, int* returnSize, int** returnColumnSizes) {
    HashMap* map = createHashMap(1000);

    for (int i = 0; i < pathsSize; i++) {
        char* path = paths[i];
        char* token = strtok(path, " ");
        char* directory = token;

        token = strtok(NULL, " ");
        while (token != NULL) {
            char* fileName = strtok(token, "(");
            char* content = strtok(NULL, ")");

            int fullPathLen = strlen(directory) + strlen(fileName) + 2;
            char* fullPath = (char*)malloc(fullPathLen * sizeof(char));
            snprintf(fullPath, fullPathLen, "%s/%s", directory, fileName);

            addToHashMap(map, content, fullPath);

            token = strtok(NULL, " ");
        }
    }

    int resultCount = 0;
    for (int i = 0; i < map->size; i++) {
        if (map->groups[i].count > 1) {
            resultCount++;
        }
    }

    *returnSize = resultCount;
    char*** result = (char***)malloc(resultCount * sizeof(char**));
    *returnColumnSizes = (int*)malloc(resultCount * sizeof(int));

    int idx = 0;
    for (int i = 0; i < map->size; i++) {
        if (map->groups[i].count > 1) {
            (*returnColumnSizes)[idx] = map->groups[i].count;
            result[idx] = (char**)malloc(map->groups[i].count * sizeof(char*));
            for (int j = 0; j < map->groups[i].count; j++) {
                result[idx][j] = map->groups[i].paths[j];
            }
            idx++;
        } else {
            for (int j = 0; j < map->groups[i].count; j++) {
                free(map->groups[i].paths[j]);
            }
        }
    }

    freeHashMap(map);
    return result;
}