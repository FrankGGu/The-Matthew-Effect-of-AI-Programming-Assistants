#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* name;
    double value;
} Node;

typedef struct {
    char* key;
    double value;
} Pair;

typedef struct {
    char** keys;
    double* values;
    int size;
} Map;

Map* createMap(int capacity) {
    Map* map = (Map*)malloc(sizeof(Map));
    map->keys = (char**)malloc(capacity * sizeof(char*));
    map->values = (double*)malloc(capacity * sizeof(double));
    map->size = 0;
    return map;
}

void put(Map* map, char* key, double value) {
    for (int i = 0; i < map->size; i++) {
        if (strcmp(map->keys[i], key) == 0) {
            map->values[i] = value;
            return;
        }
    }
    map->keys[map->size] = strdup(key);
    map->values[map->size] = value;
    map->size++;
}

double get(Map* map, char* key) {
    for (int i = 0; i < map->size; i++) {
        if (strcmp(map->keys[i], key) == 0) {
            return map->values[i];
        }
    }
    return -1.0 / 0.0;
}

typedef struct {
    char* neighbor;
    double weight;
} Edge;

typedef struct {
    char* name;
    Edge* edges;
    int edgeCount;
} GraphNode;

typedef struct {
    GraphNode** nodes;
    int nodeCount;
} Graph;

Graph* createGraph() {
    Graph* graph = (Graph*)malloc(sizeof(Graph));
    graph->nodes = NULL;
    graph->nodeCount = 0;
    return graph;
}

void addNode(Graph* graph, char* name) {
    for (int i = 0; i < graph->nodeCount; i++) {
        if (strcmp(graph->nodes[i]->name, name) == 0) {
            return;
        }
    }
    GraphNode* node = (GraphNode*)malloc(sizeof(GraphNode));
    node->name = strdup(name);
    node->edges = NULL;
    node->edgeCount = 0;
    graph->nodes = (GraphNode**)realloc(graph->nodes, (graph->nodeCount + 1) * sizeof(GraphNode*));
    graph->nodes[graph->nodeCount++] = node;
}

void addEdge(Graph* graph, char* from, char* to, double weight) {
    int fromIndex = -1, toIndex = -1;
    for (int i = 0; i < graph->nodeCount; i++) {
        if (strcmp(graph->nodes[i]->name, from) == 0) fromIndex = i;
        if (strcmp(graph->nodes[i]->name, to) == 0) toIndex = i;
    }
    if (fromIndex == -1) {
        addNode(graph, from);
        fromIndex = graph->nodeCount - 1;
    }
    if (toIndex == -1) {
        addNode(graph, to);
        toIndex = graph->nodeCount - 1;
    }
    Edge* newEdge = (Edge*)malloc(sizeof(Edge));
    newEdge->neighbor = strdup(to);
    newEdge->weight = weight;
    graph->nodes[fromIndex]->edges = (Edge*)realloc(graph->nodes[fromIndex]->edges, (graph->nodes[fromIndex]->edgeCount + 1) * sizeof(Edge));
    graph->nodes[fromIndex]->edges[graph->nodes[fromIndex]->edgeCount++] = *newEdge;
}

double dfs(Graph* graph, char* start, char* end, Map* visited) {
    if (get(visited, start) != -1.0 / 0.0) {
        return -1.0 / 0.0;
    }
    put(visited, start, 1.0);
    for (int i = 0; i < graph->nodeCount; i++) {
        if (strcmp(graph->nodes[i]->name, start) == 0) {
            for (int j = 0; j < graph->nodes[i]->edgeCount; j++) {
                if (strcmp(graph->nodes[i]->edges[j].neighbor, end) == 0) {
                    return graph->nodes[i]->edges[j].weight;
                }
                double result = dfs(graph, graph->nodes[i]->edges[j].neighbor, end, visited);
                if (result != -1.0 / 0.0) {
                    return graph->nodes[i]->edges[j].weight * result;
                }
            }
            break;
        }
    }
    return -1.0 / 0.0;
}

double* calcEquation(char*** equations, int equationsSize, double* values, char*** query, int querySize, int* returnSize) {
    Graph* graph = createGraph();
    for (int i = 0; i < equationsSize; i++) {
        addEdge(graph, equations[i][0], equations[i][1], values[i]);
        addEdge(graph, equations[i][1], equations[i][0], 1.0 / values[i]);
    }
    double* result = (double*)malloc(querySize * sizeof(double));
    *returnSize = querySize;
    for (int i = 0; i < querySize; i++) {
        Map* visited = createMap(100);
        double val = dfs(graph, query[i][0], query[i][1], visited);
        free(visited->keys);
        free(visited->values);
        free(visited);
        result[i] = val;
    }
    return result;
}