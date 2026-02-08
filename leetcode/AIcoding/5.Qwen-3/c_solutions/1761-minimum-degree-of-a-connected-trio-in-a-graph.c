#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int* neighbors;
    int size;
} Node;

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int minTrio(int** edges, int edgesSize, int* edgesColSize) {
    int n = 0;
    for (int i = 0; i < edgesSize; i++) {
        if (edges[i][0] > n) n = edges[i][0];
        if (edges[i][1] > n) n = edges[i][1];
    }
    n++;

    Node* graph = (Node*)malloc(n * sizeof(Node));
    for (int i = 0; i < n; i++) {
        graph[i].neighbors = NULL;
        graph[i].size = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];

        int* temp = (int*)realloc(graph[u].neighbors, (graph[u].size + 1) * sizeof(int));
        if (temp) {
            temp[graph[u].size++] = v;
            graph[u].neighbors = temp;
        }

        temp = (int*)realloc(graph[v].neighbors, (graph[v].size + 1) * sizeof(int));
        if (temp) {
            temp[graph[v].size++] = u;
            graph[v].neighbors = temp;
        }
    }

    for (int i = 0; i < n; i++) {
        qsort(graph[i].neighbors, graph[i].size, sizeof(int), compare);
    }

    int minDegree = INT_MAX;

    for (int i = 1; i < n; i++) {
        for (int j = 0; j < graph[i].size; j++) {
            int jVal = graph[i].neighbors[j];
            if (jVal <= i) continue;

            for (int k = 0; k < graph[jVal].size; k++) {
                int kVal = graph[jVal].neighbors[k];
                if (kVal <= jVal) continue;

                if (kVal == i) {
                    int degree = graph[i].size + graph[jVal].size + graph[kVal].size - 6;
                    if (degree < minDegree) {
                        minDegree = degree;
                    }
                }
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(graph[i].neighbors);
    }
    free(graph);

    return minDegree == INT_MAX ? 0 : minDegree;
}