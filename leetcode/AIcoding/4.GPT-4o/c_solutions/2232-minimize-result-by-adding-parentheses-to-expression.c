#include <string.h>
#include <stdlib.h>
#include <limits.h>

int minResult(char *expression) {
    int n = strlen(expression);
    long min_value = LONG_MAX;
    char *op = NULL;

    for (int i = 0; i < n; i++) {
        if (expression[i] == '+' || expression[i] == '-') {
            op = &expression[i];
            char left[50], right[50];
            strncpy(left, expression, i);
            left[i] = '\0';
            strncpy(right, expression + i + 1, n - i - 1);
            right[n - i - 1] = '\0';

            for (int j = 0; j < 2; j++) {
                long left_value = strtol(left, NULL, 10);
                long right_value = strtol(right, NULL, 10);
                if (j == 1) {
                    left_value = strtol(left, NULL, 10) + (op[0] == '+' ? 0 : -1);
                }
                long current_value = (op[0] == '+') ? left_value + right_value : left_value - right_value;
                if (current_value < min_value) {
                    min_value = current_value;
                }
            }
        }
    }

    return (int)min_value;
}