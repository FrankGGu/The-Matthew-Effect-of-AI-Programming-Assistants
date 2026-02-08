#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * minimizeResult(char * expression){
    int plus_index = -1;
    int n = strlen(expression);
    for (int i = 0; i < n; i++) {
        if (expression[i] == '+') {
            plus_index = i;
            break;
        }
    }

    int best_left = -1;
    int best_right = -1;
    int min_val = INT_MAX;

    for (int left = 0; left < plus_index; left++) {
        for (int right = plus_index + 1; right < n; right++) {
            int num1_start = 0;
            int num1_end = left - 1;
            int num2_start = left;
            int num2_end = plus_index - 1;
            int num3_start = plus_index + 1;
            int num3_end = right;
            int num4_start = right + 1;
            int num4_end = n - 1;

            long long val1 = 1;
            if (num1_start <= num1_end) {
                char num1_str[20];
                strncpy(num1_str, expression + num1_start, num1_end - num1_start + 1);
                num1_str[num1_end - num1_start + 1] = '\0';
                val1 = atoll(num1_str);
            }

            long long val2 = 0;
            char num2_str[20];
            strncpy(num2_str, expression + num2_start, num2_end - num2_start + 1);
            num2_str[num2_end - num2_start + 1] = '\0';
            val2 = atoll(num2_str);

            long long val3 = 0;
            char num3_str[20];
            strncpy(num3_str, expression + num3_start, num3_end - num3_start + 1);
            num3_str[num3_end - num3_start + 1] = '\0';
            val3 = atoll(num3_str);

            long long val4 = 1;
            if (num4_start <= num4_end) {
                char num4_str[20];
                strncpy(num4_str, expression + num4_start, num4_end - num4_start + 1);
                num4_str[num4_end - num4_start + 1] = '\0';
                val4 = atoll(num4_str);
            }

            long long current_val = val1 * (val2 + val3) * val4;
            if (current_val < min_val) {
                min_val = current_val;
                best_left = left;
                best_right = right;
            }
        }
    }

    char* result = (char*)malloc(n + 3);
    int index = 0;

    for (int i = 0; i < n; i++) {
        if (i == best_left) {
            result[index++] = '(';
        }
        result[index++] = expression[i];
        if (i == best_right) {
            result[index++] = ')';
        }
    }
    result[index] = '\0';

    return result;
}