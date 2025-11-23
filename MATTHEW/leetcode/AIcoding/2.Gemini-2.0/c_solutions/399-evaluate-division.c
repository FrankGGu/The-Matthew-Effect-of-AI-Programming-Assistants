#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_VERTICES 40

typedef struct {
    char vertex[10];
    int index;
} VertexMap;

int findVertex(VertexMap *map, int mapSize, char *vertex) {
    for (int i = 0; i < mapSize; i++) {
        if (strcmp(map[i].vertex, vertex) == 0) {
            return map[i].index;
        }
    }
    return -1;
}

double dfs(int start, int end, int numVertices, double graph[MAX_VERTICES][MAX_VERTICES], int visited[MAX_VERTICES]) {
    if (start == end) {
        return 1.0;
    }

    visited[start] = 1;

    for (int i = 0; i < numVertices; i++) {
        if (graph[start][i] != 0.0 && !visited[i]) {
            double result = dfs(i, end, numVertices, graph, visited);
            if (result != -1.0) {
                return graph[start][i] * result;
            }
        }
    }

    return -1.0;
}

double* calcEquation(char ***equations, int equationsSize, int* equationsColSize, double* values, int valuesSize, char ***queries, int queriesSize, int* queriesColSize, int* returnSize) {
    VertexMap vertexMap[MAX_VERTICES];
    int numVertices = 0;
    double graph[MAX_VERTICES][MAX_VERTICES];
    for (int i = 0; i < MAX_VERTICES; i++) {
        for (int j = 0; j < MAX_VERTICES; j++) {
            graph[i][j] = 0.0;
        }
    }

    for (int i = 0; i < equationsSize; i++) {
        char *v1 = equations[i][0];
        char *v2 = equations[i][1];

        int index1 = findVertex(vertexMap, numVertices, v1);
        if (index1 == -1) {
            strcpy(vertexMap[numVertices].vertex, v1);
            vertexMap[numVertices].index = numVertices;
            index1 = numVertices;
            numVertices++;
        }

        int index2 = findVertex(vertexMap, numVertices, v2);
        if (index2 == -1) {
            strcpy(vertexMap[numVertices].vertex, v2);
            vertexMap[numVertices].index = numVertices;
            index2 = numVertices;
            numVertices++;
        }

        graph[index1][index2] = values[i];
        graph[index2][index1] = 1.0 / values[i];
    }

    double *results = (double *)malloc(queriesSize * sizeof(double));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        char *v1 = queries[i][0];
        char *v2 = queries[i][1];

        int index1 = findVertex(vertexMap, numVertices, v1);
        int index2 = findVertex(vertexMap, numVertices, v2);

        if (index1 == -1 || index2 == -1) {
            results[i] = -1.0;
        } else {
            int visited[MAX_VERTICES] = {0};
            results[i] = dfs(index1, index2, numVertices, graph, visited);
        }
    }

    return results;
}