#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* key;
    double value;
} Pair;

typedef struct {
    char** keys;
    double* values;
    int size;
} HashMap;

typedef struct {
    char* node;
    double weight;
} Edge;

typedef struct {
    Edge* edges;
    int capacity;
    int size;
} Graph;

HashMap* createHashMap() {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    map->keys = NULL;
    map->values = NULL;
    map->size = 0;
    return map;
}

void put(HashMap* map, char* key, double value) {
    for (int i = 0; i < map->size; i++) {
        if (strcmp(map->keys[i], key) == 0) {
            map->values[i] = value;
            return;
        }
    }
    map->size++;
    map->keys = (char**)realloc(map->keys, map->size * sizeof(char*));
    map->values = (double*)realloc(map->values, map->size * sizeof(double));
    map->keys[map->size - 1] = strdup(key);
    map->values[map->size - 1] = value;
}

double get(HashMap* map, char* key) {
    for (int i = 0; i < map->size; i++) {
        if (strcmp(map->keys[i], key) == 0) {
            return map->values[i];
        }
    }
    return -1.0 / 0.0;
}

void freeHashMap(HashMap* map) {
    for (int i = 0; i < map->size; i++) {
        free(map->keys[i]);
    }
    free(map->keys);
    free(map->values);
    free(map);
}

Graph* createGraph() {
    Graph* graph = (Graph*)malloc(sizeof(Graph));
    graph->edges = NULL;
    graph->capacity = 0;
    graph->size = 0;
    return graph;
}

void addEdge(Graph* graph, char* from, char* to, double weight) {
    graph->size++;
    graph->edges = (Edge*)realloc(graph->edges, graph->size * sizeof(Edge));
    graph->edges[graph->size - 1].node = strdup(from);
    graph->edges[graph->size - 1].weight = weight;
}

void freeGraph(Graph* graph) {
    for (int i = 0; i < graph->size; i++) {
        free(graph->edges[i].node);
    }
    free(graph->edges);
    free(graph);
}

double dfs(char* start, char* end, HashMap* visited, Graph* graph) {
    if (strcmp(start, end) == 0) {
        return 1.0;
    }
    visited->size++;
    visited->keys = (char**)realloc(visited->keys, visited->size * sizeof(char*));
    visited->values = (double*)realloc(visited->values, visited->size * sizeof(double));
    visited->keys[visited->size - 1] = strdup(start);
    visited->values[visited->size - 1] = 1.0;

    for (int i = 0; i < graph->size; i++) {
        if (strcmp(graph->edges[i].node, start) == 0) {
            char* neighbor = graph->edges[i].node;
            double weight = graph->edges[i].weight;
            if (get(visited, neighbor) != -1.0 / 0.0) {
                continue;
            }
            double result = dfs(neighbor, end, visited, graph);
            if (result != -1.0 / 0.0) {
                return result * weight;
            }
        }
    }
    return -1.0 / 0.0;
}

double* calcEquation(char*** equations, int equationsSize, double* values, char*** querys, int querysSize, int* returnSize) {
    HashMap* varMap = createHashMap();
    Graph* graph = createGraph();

    for (int i = 0; i < equationsSize; i++) {
        char* a = equations[i][0];
        char* b = equations[i][1];
        double val = values[i];

        if (get(varMap, a) == -1.0 / 0.0) {
            put(varMap, a, varMap->size);
        }
        if (get(varMap, b) == -1.0 / 0.0) {
            put(varMap, b, varMap->size);
        }

        addEdge(graph, a, b, val);
        addEdge(graph, b, a, 1.0 / val);
    }

    double* result = (double*)malloc(querysSize * sizeof(double));
    *returnSize = querysSize;

    for (int i = 0; i < querysSize; i++) {
        char* a = querys[i][0];
        char* b = querys[i][1];

        if (get(varMap, a) == -1.0 / 0.0 || get(varMap, b) == -1.0 / 0.0) {
            result[i] = -1.0 / 0.0;
            continue;
        }

        HashMap* visited = createHashMap();
        double res = dfs(a, b, visited, graph);
        freeHashMap(visited);
        result[i] = res;
    }

    freeHashMap(varMap);
    freeGraph(graph);

    return result;
}