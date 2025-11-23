#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int *data;
    int size;
    int capacity;
} IntArray;

void initIntArray(IntArray *arr) {
    arr->data = NULL;
    arr->size = 0;
    arr->capacity = 0;
}

void appendIntArray(IntArray *arr, int val) {
    if (arr->size == arr->capacity) {
        arr->capacity = (arr->capacity == 0) ? 1 : arr->capacity * 2;
        arr->data = (int*)realloc(arr->data, arr->capacity * sizeof(int));
    }
    arr->data[arr->size++] = val;
}

void freeIntArray(IntArray *arr) {
    free(arr->data);
    arr->data = NULL;
    arr->size = 0;
    arr->capacity = 0;
}

typedef struct {
    IntArray *data;
    int size;
    int capacity;
} IntArrayArray;

void initIntArrayArray(IntArrayArray *arr) {
    arr->data = NULL;
    arr->size = 0;
    arr->capacity = 0;
}

void appendIntArrayArray(IntArrayArray *arr, IntArray *val) {
    if (arr->size == arr->capacity) {
        arr->capacity = (arr->capacity == 0) ? 1 : arr->capacity * 2;
        arr->data = (IntArray*)realloc(arr->data, arr->capacity * sizeof(IntArray));
    }
    arr->data[arr->size++] = *val;
}

void freeIntArrayArray(IntArrayArray *arr) {
    for (int i = 0; i < arr->size; i++) {
        freeIntArray(&arr->data[i]);
    }
    free(arr->data);
    arr->data = NULL;
    arr->size = 0;
    arr->capacity = 0;
}

typedef struct {
    int *data;
    int size;
    int capacity;
} IntSet;

void initIntSet(IntSet *set) {
    set->data = NULL;
    set->size = 0;
    set->capacity = 0;
}

bool containsIntSet(IntSet *set, int val) {
    for (int i = 0; i < set->size; i++) {
        if (set->data[i] == val) {
            return true;
        }
    }
    return false;
}

void addIntSet(IntSet *set, int val) {
    if (containsIntSet(set, val)) {
        return;
    }
    if (set->size == set->capacity) {
        set->capacity = (set->capacity == 0) ? 1 : set->capacity * 2;
        set->data = (int*)realloc(set->data, set->capacity * sizeof(int));
    }
    set->data[set->size++] = val;
}

void freeIntSet(IntSet *set) {
    free(set->data);
    set->data = NULL;
    set->size = 0;
    set->capacity = 0;
}

void findSubsequencesRecursive(int* nums, int numsSize, int index, IntArray* current, IntArrayArray* result) {
    if (current->size >= 2) {
        IntArray temp;
        initIntArray(&temp);
        for (int i = 0; i < current->size; i++) {
            appendIntArray(&temp, current->data[i]);
        }
        appendIntArrayArray(result, &temp);
    }

    IntSet used;
    initIntSet(&used);

    for (int i = index; i < numsSize; i++) {
        if ((current->size == 0 || nums[i] >= current->data[current->size - 1]) && !containsIntSet(&used, nums[i])) {
            appendIntArray(current, nums[i]);
            findSubsequencesRecursive(nums, numsSize, i + 1, current, result);
            current->size--;
            addIntSet(&used, nums[i]);
        }
    }
    freeIntSet(&used);
}

IntArrayArray findSubsequences(int* nums, int numsSize, int* returnSize) {
    IntArrayArray result;
    initIntArrayArray(&result);
    IntArray current;
    initIntArray(&current);

    findSubsequencesRecursive(nums, numsSize, 0, &current, &result);

    freeIntArray(&current);

    *returnSize = result.size;
    IntArrayArray finalResult = result;

    return finalResult;
}