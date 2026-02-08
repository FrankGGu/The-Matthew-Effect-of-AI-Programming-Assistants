#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* numsSameConsecDiff(int n, int k, int* returnSize) {
    if (n == 1) {
        int* result = (int*)malloc(10 * sizeof(int));
        for (int i = 0; i < 10; i++) {
            result[i] = i;
        }
        *returnSize = 10;
        return result;
    }

    int count = 0;
    int* tempResult = (int*)malloc(10000 * sizeof(int));

    void dfs(int num, int digits) {
        if (digits == n) {
            tempResult[count++] = num;
            return;
        }

        int lastDigit = num % 10;
        int nextDigit1 = lastDigit + k;
        int nextDigit2 = lastDigit - k;

        if (nextDigit1 >= 0 && nextDigit1 <= 9) {
            dfs(num * 10 + nextDigit1, digits + 1);
        }

        if (k != 0 && nextDigit2 >= 0 && nextDigit2 <= 9) {
            dfs(num * 10 + nextDigit2, digits + 1);
        }
    }

    for (int i = 1; i <= 9; i++) {
        dfs(i, 1);
    }

    int* result = (int*)malloc(count * sizeof(int));
    int j = 0;
    for (int i = 0; i < count; i++) {
        result[j++] = tempResult[i];
    }

    free(tempResult);

    *returnSize = count;
    return result;
}