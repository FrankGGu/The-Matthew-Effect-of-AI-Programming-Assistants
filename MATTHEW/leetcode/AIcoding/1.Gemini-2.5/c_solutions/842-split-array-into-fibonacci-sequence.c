#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <limits.h>

bool backtrack(char *S, int len, int start, int *current_fib_sequence, int *current_fib_size) {
    if (start == len) {
        return *current_fib_size >= 3;
    }

    long long current_num_val = 0;
    for (int i = start; i < len; i++) {
        if (S[start] == '0' && i > start) {
            break;
        }

        current_num_val = current_num_val * 10 + (S[i] - '0');

        if (current_num_val > INT_MAX) {
            break;
        }

        int num = (int)current_num_val;

        if (*current_fib_size < 2) {
            current_fib_sequence[*current_fib_size] = num;
            (*current_fib_size)++;
            if (backtrack(S, len, i + 1, current_fib_sequence, current_fib_size)) {
                return true;
            }
            (*current_fib_size)--;
        } else {
            long long sum = (long long)current_fib_sequence[*current_fib_size - 2] + (long long)current_fib_sequence[*current_fib_size - 1];

            if (num < sum) {
                continue;
            } else if (num > sum) {
                break;
            } else {
                current_fib_sequence[*current_fib_size] = num;
                (*current_fib_size)++;
                if (backtrack(S, len, i + 1, current_fib_sequence, current_fib_size)) {
                    return true;
                }
                (*current_fib_size)--;
            }
        }
    }
    return false;
}

int* splitIntoFibonacci(char *S, int* returnSize) {
    int len = strlen(S);
    int *result = (int*)malloc(len * sizeof(int));
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }
    int result_size = 0;

    if (backtrack(S, len, 0, result, &result_size)) {
        int *final_result = (int*)realloc(result, result_size * sizeof(int));
        if (final_result == NULL) {
            free(result);
            *returnSize = 0;
            return NULL;
        }
        *returnSize = result_size;
        return final_result;
    } else {
        free(result);
        *returnSize = 0;
        return NULL;
    }
}