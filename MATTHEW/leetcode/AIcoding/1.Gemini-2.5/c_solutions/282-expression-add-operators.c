#include <stdlib.h>
#include <string.h>
#include <stdio.h>

void backtrack(char *num, int num_len, long long target, int index,
               long long current_val, long long last_operand,
               char *path, int path_len,
               char ***result, int *result_size, int *result_capacity) {

    if (index == num_len) {
        if (current_val == target) {
            if (*result_size == *result_capacity) {
                *result_capacity = (*result_capacity == 0) ? 1 : *result_capacity * 2;
                *result = (char**)realloc(*result, sizeof(char*) * (*result_capacity));
            }
            path[path_len] = '\0';
            (*result)[*result_size] = (char*)malloc(sizeof(char) * (path_len + 1));
            strcpy((*result)[*result_size], path);
            (*result_size)++;
        }
        return;
    }

    long long current_num_val = 0;
    int original_path_len = path_len;

    for (int i = index; i < num_len; i++) {
        if (i > index && num[index] == '0') {
            break;
        }

        current_num_val = current_num_val * 10 + (num[i] - '0');

        int len_current_num_digits = i - index + 1;

        if (index == 0) {
            for (int k = 0; k < len_current_num_digits; k++) {
                path[path_len + k] = num[index + k];
            }
            path_len += len_current_num_digits;

            backtrack(num, num_len, target, i + 1,
                      current_num_val, current_num_val,
                      path, path_len,
                      result, result_size, result_capacity);

            path_len = original_path_len;
        } else {
            // Add '+'
            path[path_len] = '+';
            for (int k = 0; k < len_current_num_digits; k++) {
                path[path_len + 1 + k] = num[index + k];
            }
            path_len += 1 + len_current_num_digits;
            backtrack(num, num_len, target, i + 1,
                      current_val + current_num_val, current_num_val,
                      path, path_len,
                      result, result_size, result_capacity);
            path_len = original_path_len;

            // Add '-'
            path[path_len] = '-';
            for (int k = 0; k < len_current_num_digits; k++) {
                path[path_len + 1 + k] = num[index + k];
            }
            path_len += 1 + len_current_num_digits;
            backtrack(num, num_len, target, i + 1,
                      current_val - current_num_val, -current_num_val,
                      path, path_len,
                      result, result_size, result_capacity);
            path_len = original_path_len;

            // Add '*'
            path[path_len] = '*';
            for (int k = 0; k < len_current_num_digits; k++) {
                path[path_len + 1 + k] = num[index + k];
            }
            path_len += 1 + len_current_num_digits;
            backtrack(num, num_len, target, i + 1,
                      current_val - last_operand + (last_operand * current_num_val),
                      last_operand * current_num_val,
                      path, path_len,
                      result, result_size, result_capacity);
            path_len = original_path_len;
        }
    }
}

char ** addOperators(char * num, int target, int* returnSize) {
    int num_len = strlen(num);
    char **result = NULL;
    *returnSize = 0;
    int result_capacity = 0;

    char *path = (char*)malloc(sizeof(char) * (2 * num_len));

    backtrack(num, num_len, (long long)target, 0,
              0, 0,
              path, 0,
              &result, returnSize, &result_capacity);

    free(path);

    return result;
}