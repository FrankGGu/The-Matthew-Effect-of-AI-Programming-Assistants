#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int x;
    int y;
    int radius;
} Bomb;

typedef struct {
    int* data;
    int size;
    int capacity;
} List;

List* createList(int capacity) {
    List* list = (List*)malloc(sizeof(List));
    list->data = (int*)malloc(capacity * sizeof(int));
    list->size = 0;
    list->capacity = capacity;
    return list;
}

void freeList(List* list) {
    free(list->data);
    free(list);
}

void addToList(List* list, int value) {
    if (list->size >= list->capacity) {
        list->capacity *= 2;
        list->data = (int*)realloc(list->data, list->capacity * sizeof(int));
    }
    list->data[list->size++] = value;
}

bool isAdjacent(Bomb a, Bomb b) {
    int dx = a.x - b.x;
    int dy = a.y - b.y;
    return dx * dx + dy * dy <= a.radius * a.radius;
}

int dfs(int node, Bomb* bombs, bool* visited, int* graph, int n) {
    visited[node] = true;
    int count = 1;
    for (int i = 0; i < n; i++) {
        if (graph[node * n + i] && !visited[i]) {
            count += dfs(i, bombs, visited, graph, n);
        }
    }
    return count;
}

int maximumDetonation(int** bombs, int bombsSize, int* bombsColSize) {
    Bomb* bombList = (Bomb*)malloc(bombsSize * sizeof(Bomb));
    for (int i = 0; i < bombsSize; i++) {
        bombList[i].x = bombs[i][0];
        bombList[i].y = bombs[i][1];
        bombList[i].radius = bombs[i][2];
    }

    int* graph = (int*)calloc(bombsSize * bombsSize, sizeof(int));
    for (int i = 0; i < bombsSize; i++) {
        for (int j = 0; j < bombsSize; j++) {
            if (i != j && isAdjacent(bombList[i], bombList[j])) {
                graph[i * bombsSize + j] = 1;
            }
        }
    }

    int maxCount = 0;
    for (int i = 0; i < bombsSize; i++) {
        bool* visited = (bool*)calloc(bombsSize, sizeof(bool));
        int count = dfs(i, bombList, visited, graph, bombsSize);
        maxCount = (count > maxCount) ? count : maxCount;
        free(visited);
    }

    free(bombList);
    free(graph);
    return maxCount;
}