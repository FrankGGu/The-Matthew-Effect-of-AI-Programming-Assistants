#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int** createMatrix(int n, int m) {
    int** matrix = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        matrix[i] = (int*)malloc(m * sizeof(int));
        memset(matrix[i], 0, m * sizeof(int));
    }
    return matrix;
}

void freeMatrix(int** matrix, int n) {
    for (int i = 0; i < n; i++) {
        free(matrix[i]);
    }
    free(matrix);
}

int computeOverlap(char* s1, char* s2) {
    int len = 0;
    int minLen = min(strlen(s1), strlen(s2));
    for (int i = 1; i <= minLen; i++) {
        if (strncmp(s1 + strlen(s1) - i, s2, i) == 0) {
            len = i;
        }
    }
    return len;
}

char* findShortestSuperstring(char** A, int ASize) {
    int n = ASize;
    int** overlap = createMatrix(n, n);
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (i != j) {
                overlap[i][j] = computeOverlap(A[i], A[j]);
            }
        }
    }

    int** dp = createMatrix(n, 1 << n);
    int** prev = createMatrix(n, 1 << n);

    for (int i = 0; i < n; i++) {
        dp[i][1 << i] = strlen(A[i]);
    }

    for (int mask = 1; mask < (1 << n); mask++) {
        for (int last = 0; last < n; last++) {
            if ((mask & (1 << last)) == 0) continue;
            for (int curr = 0; curr < n; curr++) {
                if ((mask & (1 << curr)) || last == curr) continue;
                int new_mask = mask | (1 << curr);
                int cost = dp[last][mask] + overlap[last][curr];
                if (dp[curr][new_mask] < cost) {
                    dp[curr][new_mask] = cost;
                    prev[curr][new_mask] = last;
                }
            }
        }
    }

    int best = 0, best_idx = 0;
    for (int i = 0; i < n; i++) {
        if (dp[i][(1 << n) - 1] > best) {
            best = dp[i][(1 << n) - 1];
            best_idx = i;
        }
    }

    int* path = (int*)malloc(n * sizeof(int));
    int idx = 0;
    int mask = (1 << n) - 1;
    while (idx < n) {
        path[idx++] = best_idx;
        int prev_idx = prev[best_idx][mask];
        mask ^= (1 << best_idx);
        best_idx = prev_idx;
    }

    char* result = (char*)malloc(1);
    result[0] = '\0';
    for (int i = idx - 1; i >= 0; i--) {
        int pos = path[i];
        char* s = A[pos];
        int len = strlen(result);
        int overlap_len = (i == idx - 1) ? 0 : overlap[path[i + 1]][pos];
        char* temp = (char*)malloc(len + strlen(s) - overlap_len + 1);
        strncpy(temp, result, len);
        strncpy(temp + len, s + overlap_len, strlen(s) - overlap_len);
        temp[len + strlen(s) - overlap_len] = '\0';
        free(result);
        result = temp;
    }

    freeMatrix(dp, n);
    freeMatrix(prev, n);
    free(overlap);
    free(path);
    return result;
}