#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* getPatternIndices(int* arr, int n, int m, int k, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i <= n - m; i++) {
        int count = 1;
        for (int j = i + m; j <= n - m; j += m) {
            int match = 1;
            for (int p = 0; p < m; p++) {
                if (arr[i + p] != arr[j + p]) {
                    match = 0;
                    break;
                }
            }
            if (match) {
                count++;
                if (count >= k) {
                    result[*returnSize] = i;
                    (*returnSize)++;
                    break;
                }
            } else {
                break;
            }
        }
    }

    return result;
}

bool checkPattern(int* arr, int n, int m, int k) {
    for (int i = 0; i <= n - m; i++) {
        int count = 1;
        for (int j = i + m; j <= n - m; j += m) {
            int match = 1;
            for (int p = 0; p < m; p++) {
                if (arr[i + p] != arr[j + p]) {
                    match = 0;
                    break;
                }
            }
            if (match) {
                count++;
                if (count >= k) {
                    return true;
                }
            } else {
                break;
            }
        }
    }
    return false;
}

bool* findPatterns(int* arr, int n, int m, int k, int* returnSize) {
    bool* result = (bool*)malloc(n * sizeof(bool));
    *returnSize = 0;

    for (int i = 0; i <= n - m; i++) {
        int count = 1;
        for (int j = i + m; j <= n - m; j += m) {
            int match = 1;
            for (int p = 0; p < m; p++) {
                if (arr[i + p] != arr[j + p]) {
                    match = 0;
                    break;
                }
            }
            if (match) {
                count++;
                if (count >= k) {
                    result[*returnSize] = true;
                    (*returnSize)++;
                    break;
                }
            } else {
                break;
            }
        }
    }

    return result;
}

int* findPattern(int* arr, int n, int m, int k, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i <= n - m; i++) {
        int count = 1;
        for (int j = i + m; j <= n - m; j += m) {
            int match = 1;
            for (int p = 0; p < m; p++) {
                if (arr[i + p] != arr[j + p]) {
                    match = 0;
                    break;
                }
            }
            if (match) {
                count++;
                if (count >= k) {
                    result[*returnSize] = i;
                    (*returnSize)++;
                    break;
                }
            } else {
                break;
            }
        }
    }

    return result;
}

int hasPattern(int* arr, int n, int m, int k) {
    for (int i = 0; i <= n - m; i++) {
        int count = 1;
        for (int j = i + m; j <= n - m; j += m) {
            int match = 1;
            for (int p = 0; p < m; p++) {
                if (arr[i + p] != arr[j + p]) {
                    match = 0;
                    break;
                }
            }
            if (match) {
                count++;
                if (count >= k) {
                    return 1;
                }
            } else {
                break;
            }
        }
    }
    return 0;
}