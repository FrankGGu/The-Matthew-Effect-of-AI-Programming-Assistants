#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* data;
    int size;
} List;

List* createList(int capacity) {
    List* list = (List*)malloc(sizeof(List));
    list->data = (int*)malloc(capacity * sizeof(int));
    list->size = 0;
    return list;
}

void addToList(List* list, int value) {
    list->data[list->size++] = value;
}

void freeList(List* list) {
    free(list->data);
    free(list);
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int* sortItems(int n, int m, int* group, int groupSize, int** beforeItems, int* beforeItemsSize, int* returnSize) {
    int** graph = (int**)malloc((n + m) * sizeof(int*));
    for (int i = 0; i < n + m; i++) {
        graph[i] = (int*)malloc(n * sizeof(int));
        memset(graph[i], -1, n * sizeof(int));
    }

    int* inDegree = (int*)malloc((n + m) * sizeof(int));
    memset(inDegree, 0, (n + m) * sizeof(int));

    for (int i = 0; i < n; i++) {
        int g = group[i];
        if (g == -1) {
            continue;
        }
        for (int j = 0; j < beforeItemsSize[i]; j++) {
            int prev = beforeItems[i][j];
            if (group[prev] == -1) {
                continue;
            }
            if (graph[g][prev] == -1) {
                graph[g][prev] = 1;
                inDegree[g]++;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        int g = group[i];
        if (g == -1) {
            continue;
        }
        for (int j = 0; j < beforeItemsSize[i]; j++) {
            int prev = beforeItems[i][j];
            if (group[prev] == -1) {
                continue;
            }
            if (graph[prev][i] == -1) {
                graph[prev][i] = 1;
                inDegree[prev]++;
            }
        }
    }

    List** groupOrder = (List**)malloc((n + m) * sizeof(List*));
    for (int i = 0; i < n + m; i++) {
        groupOrder[i] = createList(n);
    }

    int* queue = (int*)malloc((n + m) * sizeof(int));
    int front = 0, rear = 0;
    for (int i = 0; i < n + m; i++) {
        if (inDegree[i] == 0) {
            queue[rear++] = i;
        }
    }

    while (front < rear) {
        int u = queue[front++];
        addToList(groupOrder[u], u);

        for (int v = 0; v < n; v++) {
            if (graph[u][v] == 1) {
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    queue[rear++] = v;
                }
            }
        }
    }

    for (int i = 0; i < n + m; i++) {
        if (inDegree[i] != 0) {
            *returnSize = 0;
            return NULL;
        }
    }

    List* result = createList(n);
    for (int i = 0; i < n + m; i++) {
        for (int j = 0; j < groupOrder[i]->size; j++) {
            addToList(result, groupOrder[i]->data[j]);
        }
    }

    *returnSize = result->size;
    int* res = (int*)malloc(*returnSize * sizeof(int));
    memcpy(res, result->data, *returnSize * sizeof(int));
    freeList(result);
    for (int i = 0; i < n + m; i++) {
        freeList(groupOrder[i]);
    }
    free(groupOrder);
    free(queue);
    for (int i = 0; i < n + m; i++) {
        free(graph[i]);
    }
    free(graph);
    free(inDegree);
    return res;
}