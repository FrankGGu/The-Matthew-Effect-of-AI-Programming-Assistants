#include <stdio.h>
#include <stdlib.h>

int dfs(int *statements, int n, int *good, int idx, int count) {
    if (idx == n) {
        for (int i = 0; i < n; i++) {
            if (good[i]) {
                for (int j = 0; j < n; j++) {
                    if ((statements[i] >> j) & 1) {
                        if (!good[j]) return 0;
                    } else {
                        if ((statements[i] >> j) & 1) return 0;
                    }
                }
            }
        }
        return count;
    }

    good[idx] = 1;
    int with = dfs(statements, n, good, idx + 1, count + 1);

    good[idx] = 0;
    int without = dfs(statements, n, good, idx + 1, count);

    return with > without ? with : without;
}

int maximumGood(int** statements, int statementsSize, int* statementsColSize) {
    int *good = (int *)calloc(statementsSize, sizeof(int));
    return dfs(statements, statementsSize, good, 0, 0);
}