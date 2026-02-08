#include <stdlib.h>

void dfs(int num, int n, int k, int current_len, int** result, int* returnSize, int* capacity) {
    if (current_len == n) {
        if (*returnSize == *capacity) {
            *capacity *= 2;
            *result = (int*)realloc(*result, (*capacity) * sizeof(int));
        }
        (*result)[(*returnSize)++] = num;
        return;
    }

    int last_digit = num % 10;

    int next_digit1 = last_digit + k;
    if (next_digit1 >= 0 && next_digit1 <= 9) {
        dfs(num * 10 + next_digit1, n, k, current_len + 1, result, returnSize, capacity);
    }

    if (k != 0) {
        int next_digit2 = last_digit - k;
        if (next_digit2 >= 0 && next_digit2 <= 9) {
            dfs(num * 10 + next_digit2, n, k, current_len + 1, result, returnSize, capacity);
        }
    }
}

int* numsSameConsecDiff(int n, int k, int* returnSize) {
    int initial_capacity = 16;
    int* result = (int*)malloc(initial_capacity * sizeof(int));
    *returnSize = 0;
    int capacity = initial_capacity;

    if (n == 1) {
        for (int i = 0; i <= 9; ++i) {
            if (*returnSize == capacity) {
                capacity *= 2;
                result = (int*)realloc(result, capacity * sizeof(int));
            }
            result[(*returnSize)++] = i;
        }
        return result;
    }

    for (int i = 1; i <= 9; ++i) {
        dfs(i, n, k, 1, &result, returnSize, &capacity);
    }

    return result;
}