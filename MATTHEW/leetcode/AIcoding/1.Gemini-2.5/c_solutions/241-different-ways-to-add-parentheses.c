#include <stdlib.h>
#include <string.h>
#include <stdio.h> // For atoi

typedef struct {
    int* arr;
    int capacity;
    int size;
} IntList;

void initIntList(IntList* list) {
    list->arr = NULL;
    list->capacity = 0;
    list->size = 0;
}

void addToIntList(IntList* list, int val) {
    if (list->size == list->capacity) {
        int newCapacity = (list->capacity == 0) ? 4 : list->capacity * 2;
        int* newArr = (int*)realloc(list->arr, newCapacity * sizeof(int));
        list->arr = newArr;
        list->capacity = newCapacity;
    }
    list->arr[list->size++] = val;
}

void freeIntList(IntList* list) {
    free(list->arr);
    list->arr = NULL;
    list->capacity = 0;
    list->size = 0;
}

#define MAX_MEMO_NODES 250 

typedef struct {
    char* expression_key; // Dynamically allocated copy of substring
    IntList results_list; // Deep copy of the results
} MemoEntry;

MemoEntry memo_table[MAX_MEMO_NODES];
int memo_table_count = 0;

MemoEntry* findMemoEntry(char* expression) {
    for (int i = 0; i < memo_table_count; ++i) {
        if (strcmp(memo_table[i].expression_key, expression) == 0) {
            return &memo_table[i];
        }
    }
    return NULL;
}

MemoEntry* addMemoEntry(char* expression, IntList* results) {
    if (memo_table_count >= MAX_MEMO_NODES) {
        return NULL; 
    }
    MemoEntry* newEntry = &memo_table[memo_table_count++];
    newEntry->expression_key = strdup(expression); // Copy the string key

    // Deep copy results_list.arr
    newEntry->results_list.arr = (int*)malloc(results->size * sizeof(int));
    memcpy(newEntry->results_list.arr, results->arr, results->size * sizeof(int));
    newEntry->results_list.size = results->size;
    newEntry->results_list.capacity = results->size; // Capacity becomes size after copy

    return newEntry;
}

void clearMemoTable() {
    for (int i = 0; i < memo_table_count; ++i) {
        free(memo_table[i].expression_key);
        free(memo_table[i].results_list.arr);
    }
    memo_table_count = 0;
}

IntList compute(char* expression) {
    IntList resultList;
    initIntList(&resultList);

    // Check memoization table first
    MemoEntry* entry = findMemoEntry(expression);
    if (entry != NULL) {
        // Deep copy the stored results from memoization
        resultList.size = entry->results_list.size;
        resultList.capacity = entry->results_list.size;
        resultList.arr = (int*)malloc(resultList.capacity * sizeof(int));
        memcpy(resultList.arr, entry->results_list.arr, resultList.size * sizeof(int));
        return resultList;
    }

    int len = strlen(expression);
    int isNumber = 1; // Flag to check if the expression is just a number

    for (int i = 0; i < len; ++i) {
        char c = expression[i];
        if (c == '+' || c == '-' || c == '*') {
            isNumber = 0; // Found an operator, so it's not just a number

            // Split into left and right parts
            char* left_expr = (char*)malloc((i + 1) * sizeof(char));
            strncpy(left_expr, expression, i);
            left_expr[i] = '\0';

            char* right_expr = (char*)malloc((len - i) * sizeof(char));
            strcpy(right_expr, expression + i + 1);

            // Recursively compute results for left and right parts
            IntList left_results = compute(left_expr);
            IntList right_results = compute(right_expr);

            // Combine results
            for (int l = 0; l < left_results.size; ++l) {
                for (int r = 0; r < right_results.size; ++r) {
                    int val;
                    switch (c) {
                        case '+': val = left_results.arr[l] + right_results.arr[r]; break;
                        case '-': val = left_results.arr[l] - right_results.arr[r]; break;
                        case '*': val = left_results.arr[l] * right_results.arr[r]; break;
                    }
                    addToIntList(&resultList, val);
                }
            }

            // Free temporary memory for sub-expressions and their results
            free(left_expr);
            free(right_expr);
            freeIntList(&left_results);
            freeIntList(&right_results);
        }
    }

    // Base case: if no operator was found, the expression is a single number
    if (isNumber) {
        addToIntList(&resultList, atoi(expression));
    }

    // Store the computed results in the memoization table
    addMemoEntry(expression, &resultList);

    return resultList;
}

int* diffWaysToCompute(char* expression, int* returnSize) {
    // Clear the memoization table at the start of each test case
    clearMemoTable(); 

    IntList finalResults = compute(expression);
    *returnSize = finalResults.size;

    // Allocate memory for the final result array to be returned
    int* resultArr = (int*)malloc(finalResults.size * sizeof(int));
    memcpy(resultArr, finalResults.arr, finalResults.size * sizeof(int));

    // Free the temporary IntList created by the top-level compute call
    freeIntList(&finalResults); 

    return resultArr;
}