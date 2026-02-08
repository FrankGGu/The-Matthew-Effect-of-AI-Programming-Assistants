#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* constructDistancedSequence(int n, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * (2 * n - 1));
    *returnSize = 2 * n - 1;
    memset(result, 0, sizeof(int) * (2 * n - 1));
    int* used = (int*)malloc(sizeof(int) * (n + 1));
    memset(used, 0, sizeof(int) * (n + 1));

    function(result, 0, n, used);

    free(used);
    return result;
}

int function(int* result, int index, int n, int* used) {
    if (index == 2 * n - 1) {
        return 1;
    }

    if (result[index] != 0) {
        return function(result, index + 1, n, used);
    }

    for (int i = n; i >= 1; i--) {
        if (!used[i]) {
            if (i == 1) {
                used[i] = 1;
                result[index] = i;
                if (function(result, index + 1, n, used)) {
                    return 1;
                }
                result[index] = 0;
                used[i] = 0;
            } else if (index + i < 2 * n) {
                if (result[index + i] == 0) {
                    used[i] = 1;
                    result[index] = i;
                    result[index + i] = i;
                    if (function(result, index + 1, n, used)) {
                        return 1;
                    }
                    result[index] = 0;
                    result[index + i] = 0;
                    used[i] = 0;
                }
            }
        }
    }

    return 0;
}