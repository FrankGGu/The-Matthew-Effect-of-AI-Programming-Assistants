#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int dp(int* slices, int n, int start, int end, int** memo) {
    if (start > end) return 0;
    if (memo[start][end] != -1) return memo[start][end];

    int pick = slices[start] + dp(slices, n, start + 2, end, memo);
    int not_pick = dp(slices, n, start + 1, end, memo);

    memo[start][end] = max(pick, not_pick);
    return memo[start][end];
}

int mostSlices(int* slices, int slicesSize) {
    int n = slicesSize;
    int** memo = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        memo[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            memo[i][j] = -1;
        }
    }

    int option1 = dp(slices, n, 0, n - 2, memo);
    int option2 = dp(slices, n, 1, n - 1, memo);

    for (int i = 0; i < n; i++) {
        free(memo[i]);
    }
    free(memo);

    return max(option1, option2);
}

int mostSlices(int* slices, int slicesSize);