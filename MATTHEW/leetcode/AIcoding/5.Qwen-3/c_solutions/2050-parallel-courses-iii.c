#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

typedef struct {
    int* data;
    int size;
    int capacity;
} Vector;

Vector* vector_create() {
    Vector* v = (Vector*)malloc(sizeof(Vector));
    v->size = 0;
    v->capacity = 1;
    v->data = (int*)malloc(sizeof(int) * v->capacity);
    return v;
}

void vector_push(Vector* v, int val) {
    if (v->size == v->capacity) {
        v->capacity *= 2;
        v->data = (int*)realloc(v->data, sizeof(int) * v->capacity);
    }
    v->data[v->size++] = val;
}

void vector_free(Vector* v) {
    free(v->data);
    free(v);
}

int dfs(int node, int** graph, int* dp, int n) {
    if (dp[node] != -1) return dp[node];
    int max_time = 0;
    for (int i = 0; i < graph[node][0]; i++) {
        int neighbor = graph[node][i + 1];
        max_time = max(max_time, dfs(neighbor, graph, dp, n));
    }
    dp[node] = max_time + 1;
    return dp[node];
}

int parallelCourses(int n, int** relations, int relationsSize, int* relationsColSize) {
    int** graph = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        graph[i] = (int*)malloc(sizeof(int) * (n + 1));
        graph[i][0] = 0;
    }

    for (int i = 0; i < relationsSize; i++) {
        int u = relations[i][0];
        int v = relations[i][1];
        graph[u][++graph[u][0]] = v;
    }

    int* dp = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        dp[i] = -1;
    }

    int result = 0;
    for (int i = 1; i <= n; i++) {
        result = max(result, dfs(i, graph, dp, n));
    }

    for (int i = 0; i <= n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(dp);

    return result;
}