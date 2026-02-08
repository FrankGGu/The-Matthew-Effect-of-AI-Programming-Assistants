#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int *data;
    int size;
} Graph;

int gcd(int a, int b) {
    while (b) {
        int t = b;
        b = a % b;
        a = t;
    }
    return a;
}

void dfs(int node, int *visited, Graph *graph, int *reachable, int value) {
    visited[node] = 1;
    reachable[node] = 1;
    for (int i = 0; i < graph[node].size; i++) {
        int neighbor = graph[node].data[i];
        if (!visited[neighbor] && gcd(value, neighbor) > 1) {
            dfs(neighbor, visited, graph, value);
        }
    }
}

bool canTraverse(int* arr, int arrSize, int start, int end) {
    if (arr[start] == arr[end]) return true;

    int *visited = (int *)calloc(arrSize, sizeof(int));
    Graph *graph = (Graph *)malloc(arrSize * sizeof(Graph));
    for (int i = 0; i < arrSize; i++) {
        graph[i].data = (int *)malloc(arrSize * sizeof(int));
        graph[i].size = 0;
    }

    for (int i = 0; i < arrSize; i++) {
        for (int j = i + 1; j < arrSize; j++) {
            if (gcd(arr[i], arr[j]) > 1) {
                graph[i].data[graph[i].size++] = j;
                graph[j].data[graph[j].size++] = i;
            }
        }
    }

    dfs(start, visited, graph, arr[start]);

    bool result = visited[end];

    for (int i = 0; i < arrSize; i++) {
        free(graph[i].data);
    }
    free(graph);
    free(visited);

    return result;
}