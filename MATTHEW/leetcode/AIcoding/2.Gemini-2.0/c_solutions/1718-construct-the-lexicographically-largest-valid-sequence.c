#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* constructDistancedSequence(int n, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * (2 * n - 1));
    bool* used = (bool*)calloc(n + 1, sizeof(bool));
    *returnSize = 2 * n - 1;

    for (int i = 0; i < 2 * n - 1; i++) {
        result[i] = 0;
    }

    function<bool(int)> solve = [&](int index) {
        if (index == 2 * n - 1) {
            return true;
        }

        if (result[index] != 0) {
            return solve(index + 1);
        }

        for (int num = n; num >= 1; num--) {
            if (!used[num]) {
                if (num == 1) {
                    result[index] = num;
                    used[num] = true;
                    if (solve(index + 1)) {
                        return true;
                    }
                    used[num] = false;
                    result[index] = 0;
                } else if (index + num < 2 * n) {
                    if (result[index + num] == 0) {
                        result[index] = num;
                        result[index + num] = num;
                        used[num] = true;

                        if (solve(index + 1)) {
                            return true;
                        }

                        used[num] = false;
                        result[index] = 0;
                        result[index + num] = 0;
                    }
                }
            }
        }
        return false;
    };

    solve(0);

    free(used);
    return result;
}