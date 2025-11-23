#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* findUniqueBinaryString(char** nums, int numsSize) {
    int n = numsSize;
    char* result = (char*)malloc((n + 1) * sizeof(char));
    int* seen = (int*)calloc(1 << n, sizeof(int));

    for (int i = 0; i < n; i++) {
        int val = 0;
        for (int j = 0; j < n; j++) {
            val = (val << 1) | (nums[i][j] - '0');
        }
        seen[val] = 1;
    }

    for (int i = 0; i < (1 << n); i++) {
        if (!seen[i]) {
            for (int j = 0; j < n; j++) {
                result[j] = (i & (1 << (n - 1 - j))) ? '1' : '0';
            }
            result[n] = '\0';
            free(seen);
            return result;
        }
    }

    free(seen);
    return result;
}