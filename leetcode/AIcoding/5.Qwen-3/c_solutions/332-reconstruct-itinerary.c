#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* key;
    char** value;
    int size;
    int capacity;
} MapEntry;

typedef struct {
    MapEntry* entries;
    int count;
} Map;

typedef struct {
    char** data;
    int size;
    int capacity;
} StringList;

Map* createMap() {
    Map* map = (Map*)malloc(sizeof(Map));
    map->entries = NULL;
    map->count = 0;
    return map;
}

void addEdge(Map* map, char* from, char* to) {
    int found = 0;
    for (int i = 0; i < map->count; i++) {
        if (strcmp(map->entries[i].key, from) == 0) {
            found = 1;
            break;
        }
    }
    if (!found) {
        map->entries = (MapEntry*)realloc(map->entries, (map->count + 1) * sizeof(MapEntry));
        map->entries[map->count].key = strdup(from);
        map->entries[map->count].value = (char**)malloc(1 * sizeof(char*));
        map->entries[map->count].size = 0;
        map->entries[map->count].capacity = 1;
        map->count++;
    }

    for (int i = 0; i < map->count; i++) {
        if (strcmp(map->entries[i].key, from) == 0) {
            if (map->entries[i].size == map->entries[i].capacity) {
                map->entries[i].capacity *= 2;
                map->entries[i].value = (char**)realloc(map->entries[i].value, map->entries[i].capacity * sizeof(char*));
            }
            map->entries[i].value[map->entries[i].size++] = strdup(to);
            break;
        }
    }
}

StringList* createStringList() {
    StringList* list = (StringList*)malloc(sizeof(StringList));
    list->data = NULL;
    list->size = 0;
    list->capacity = 0;
    return list;
}

void appendString(StringList* list, char* str) {
    if (list->size == list->capacity) {
        list->capacity = (list->capacity == 0) ? 1 : list->capacity * 2;
        list->data = (char**)realloc(list->data, list->capacity * sizeof(char*));
    }
    list->data[list->size++] = strdup(str);
}

void freeStringList(StringList* list) {
    for (int i = 0; i < list->size; i++) {
        free(list->data[i]);
    }
    free(list->data);
    free(list);
}

void freeMap(Map* map) {
    for (int i = 0; i < map->count; i++) {
        free(map->entries[i].key);
        for (int j = 0; j < map->entries[i].size; j++) {
            free(map->entries[i].value[j]);
        }
        free(map->entries[i].value);
    }
    free(map->entries);
    free(map);
}

char** findItinerary(char*** tickets, int ticketsSize, int* ticketsColSize, int* returnSize) {
    Map* graph = createMap();
    for (int i = 0; i < ticketsSize; i++) {
        addEdge(graph, tickets[i][0], tickets[i][1]);
    }

    for (int i = 0; i < graph->count; i++) {
        qsort(graph->entries[i].value, graph->entries[i].size, sizeof(char*), (int (*)(const void*, const void*))strcmp);
    }

    StringList* result = createStringList();
    appendString(result, "JFK");

    char* current = "JFK";
    while (result->size < ticketsSize + 1) {
        int found = 0;
        for (int i = 0; i < graph->count; i++) {
            if (strcmp(graph->entries[i].key, current) == 0) {
                if (graph->entries[i].size > 0) {
                    char* next = graph->entries[i].value[0];
                    for (int j = 0; j < graph->entries[i].size - 1; j++) {
                        graph->entries[i].value[j] = graph->entries[i].value[j + 1];
                    }
                    graph->entries[i].size--;
                    appendString(result, next);
                    current = next;
                    found = 1;
                    break;
                }
            }
        }
        if (!found) {
            break;
        }
    }

    *returnSize = result->size;
    char** output = (char**)malloc(result->size * sizeof(char*));
    for (int i = 0; i < result->size; i++) {
        output[i] = result->data[i];
    }

    freeStringList(result);
    freeMap(graph);

    return output;
}