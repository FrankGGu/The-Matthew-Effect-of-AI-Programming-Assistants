#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int *data;
    int size;
    int capacity;
} Vector;

Vector* vector_create() {
    Vector *v = (Vector*)malloc(sizeof(Vector));
    v->data = NULL;
    v->size = 0;
    v->capacity = 0;
    return v;
}

void vector_push(Vector *v, int val) {
    if (v->size == v->capacity) {
        int new_cap = v->capacity ? v->capacity * 2 : 1;
        int *new_data = (int*)realloc(v->data, new_cap * sizeof(int));
        v->data = new_data;
        v->capacity = new_cap;
    }
    v->data[v->size++] = val;
}

void vector_free(Vector *v) {
    free(v->data);
    free(v);
}

typedef struct {
    int *data;
    int size;
} Result;

Result* result_create() {
    Result *r = (Result*)malloc(sizeof(Result));
    r->data = NULL;
    r->size = 0;
    return r;
}

void result_add(Result *r, int *seq, int len) {
    int *new_data = (int*)realloc(r->data, (r->size + 1) * sizeof(int));
    r->data = new_data;
    memcpy(&r->data[r->size * len], seq, len * sizeof(int));
    r->size++;
}

void result_free(Result *r) {
    free(r->data);
    free(r);
}

void backtrack(int *nums, int numsSize, int start, int *path, int pathLen, Result *result, int *prev) {
    if (pathLen >= 2) {
        result_add(result, path, pathLen);
    }

    int *seen = (int*)calloc(101, sizeof(int));
    for (int i = start; i < numsSize; i++) {
        if (seen[nums[i] + 50]) continue;
        if (pathLen == 0 || nums[i] >= path[pathLen - 1]) {
            seen[nums[i] + 50] = 1;
            path[pathLen] = nums[i];
            backtrack(nums, numsSize, i + 1, path, pathLen + 1, result, prev);
        }
    }
    free(seen);
}

int** findSubsequences(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    Result *result = result_create();
    int *path = (int*)malloc(numsSize * sizeof(int));
    backtrack(nums, numsSize, 0, path, 0, result, NULL);
    *returnSize = result->size;
    *returnColumnSizes = (int*)malloc(result->size * sizeof(int));
    for (int i = 0; i < result->size; i++) {
        (*returnColumnSizes)[i] = (i < result->size - 1) ? (i + 1) : 0;
    }
    int **output = (int**)malloc(result->size * sizeof(int*));
    for (int i = 0; i < result->size; i++) {
        output[i] = &result->data[i * (*returnColumnSizes)[i]];
    }
    result_free(result);
    free(path);
    return output;
}