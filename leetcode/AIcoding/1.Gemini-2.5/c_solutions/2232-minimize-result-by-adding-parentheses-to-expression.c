#include <string.h>
#include <stdlib.h>

char *minimizeResult(char *expression) {
    int n = strlen(expression);
    int plus_idx = -1;
    for (int k = 0; k < n; k++) {
        if (expression[k] == '+') {
            plus_idx = k;
            break;
        }
    }

    long long min_val = -1; 
    char *best_result_str = (char *)malloc(sizeof(char) * (n + 3));

    for (int i = 0; i < plus_idx; i++) {
        for (int j = plus_idx + 1; j < n; j++) {

            long long prefix_val = 1;
            if (i > 0) {
                char temp_prefix[11];
                strncpy(temp_prefix, expression, i);
                temp_prefix[i] = '\0';
                prefix_val = atol(temp_prefix);
            }

            char temp_middle_left[11];
            strncpy(temp_middle_left, expression + i, plus_idx - i);
            temp_middle_left[plus_idx - i] = '\0';
            long long middle_left_val = atol(temp_middle_left);

            char temp_middle_right[11];
            strncpy(temp_middle_right, expression + plus_idx + 1, j - (plus_idx + 1) + 1);
            temp_middle_right[j - (plus_idx + 1) + 1] = '\0';
            long long middle_right_val = atol(temp_middle_right);

            long long suffix_val = 1;
            if (j < n - 1) {
                char temp_suffix[11];
                strncpy(temp_suffix, expression + j + 1, n - (j + 1));
                temp_suffix[n - (j + 1)] = '\0';
                suffix_val = atol(temp_suffix);
            }

            long long current_val = prefix_val * (middle_left_val + middle_right_val) * suffix_val;

            if (min_val == -1 || current_val < min_val) {
                min_val = current_val;

                int current_res_idx = 0;
                for (int k = 0; k < i; k++) {
                    best_result_str[current_res_idx++] = expression[k];
                }

                best_result_str[current_res_idx++] = '(';

                for (int k = i; k < plus_idx; k++) {
                    best_result_str[current_res_idx++] = expression[k];
                }

                best_result_str[current_res_idx++] = '+';

                for (int k = plus_idx + 1; k <= j; k++) {
                    best_result_str[current_res_idx++] = expression[k];
                }

                best_result_str[current_res_idx++] = ')';

                for (int k = j + 1; k < n; k++) {
                    best_result_str[current_res_idx++] = expression[k];
                }
                best_result_str[current_res_idx] = '\0';
            }
        }
    }

    return best_result_str;
}