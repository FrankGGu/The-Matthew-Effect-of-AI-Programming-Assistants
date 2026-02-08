#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* data;
    int size;
    int capacity;
} DynamicArray;

DynamicArray* createDynamicArray(int capacity) {
    DynamicArray* arr = (DynamicArray*)malloc(sizeof(DynamicArray));
    arr->data = (int*)malloc(capacity * sizeof(int));
    arr->size = 0;
    arr->capacity = capacity;
    return arr;
}

void push(DynamicArray* arr, int value) {
    if (arr->size == arr->capacity) {
        arr->capacity *= 2;
        arr->data = (int*)realloc(arr->data, arr->capacity * sizeof(int));
    }
    arr->data[arr->size++] = value;
}

void freeDynamicArray(DynamicArray* arr) {
    free(arr->data);
    free(arr);
}

int* checkArrangement(int n, int** tickets, int ticketsSize, int* ticketsColSize, int k, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    int* visited = (int*)calloc(n, sizeof(int));
    int index = 0;

    for (int i = 0; i < n; i++) {
        if (tickets[i][0] == k) {
            result[index++] = k;
            visited[k] = 1;
            break;
        }
    }

    for (int i = 0; i < n; i++) {
        if (visited[i]) continue;
        int current = i;
        int count = 0;
        while (count < n && !visited[current]) {
            visited[current] = 1;
            result[index++] = current;
            count++;
            int found = 0;
            for (int j = 0; j < ticketsSize; j++) {
                if (tickets[j][0] == current && !visited[tickets[j][1]]) {
                    current = tickets[j][1];
                    found = 1;
                    break;
                }
            }
            if (!found) break;
        }
    }

    *returnSize = n;
    return result;
}