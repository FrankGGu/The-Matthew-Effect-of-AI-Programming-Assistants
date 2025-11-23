#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

char* my_strndup(const char *s, size_t n) {
    size_t len = 0;
    while (len < n && s[len] != '\0') {
        len++;
    }
    char *new_s = (char*)malloc(len + 1);
    if (new_s == NULL) return NULL;
    memcpy(new_s, s, len);
    new_s[len] = '\0';
    return new_s;
}

char* addStrings(char* num1, char* num2) {
    int len1 = strlen(num1);
    int len2 = strlen(num2);
    int max_len = (len1 > len2 ? len1 : len2);
    char* sum = (char*)malloc(sizeof(char) * (max_len + 2));
    if (!sum) return NULL;

    int i = len1 - 1;
    int j = len2 - 1;
    int k = 0;
    int carry = 0;

    while (i >= 0 || j >= 0 || carry > 0) {
        int digit1 = (i >= 0) ? num1[i--] - '0' : 0;
        int digit2 = (j >= 0) ? num2[j--] - '0' : 0;
        int current_sum = digit1 + digit2 + carry;
        sum[k++] = (current_sum % 10) + '0';
        carry = current_sum / 10;
    }
    sum[k] = '\0';

    int start = 0;
    int end = k - 1;
    while (start < end) {
        char temp = sum[start];
        sum[start] = sum[end];
        sum[end] = temp;
        start++;
        end--;
    }
    return sum;
}

bool check(char *num_ptr, char *prev1_str, char *prev2_str) {
    char *sum_str = addStrings(prev1_str, prev2_str);
    if (!sum_str) {
        free(prev1_str);
        free(prev2_str);
        return false;
    }

    int sum_len = strlen(sum_str);
    int num_ptr_len = strlen(num_ptr);

    if (num_ptr_len < sum_len || strncmp(num_ptr, sum_str, sum_len) != 0) {
        free(prev1_str);
        free(prev2_str);
        free(sum_str);
        return false;
    }

    if (num_ptr_len == sum_len) {
        free(prev1_str);
        free(prev2_str);
        free(sum_str);
        return true;
    }

    free(prev1_str);

    return check(num_ptr + sum_len, prev2_str, sum_str);
}

bool isAdditiveNumber(char *num) {
    int len = strlen(num);
    if (len < 3) {
        return false;
    }

    for (int i = 0; i < len - 2; i++) {
        if (i > 0 && num[0] == '0') {
            break;
        }

        for (int j = i + 1; j < len - 1; j++) {
            if (j > i + 1 && num[i + 1] == '0') {
                break;
            }

            char *num1_str_copy = my_strndup(num, i + 1);
            char *num2_str_copy = my_strndup(num + i + 1, j - (i + 1) + 1);

            if (!num1_str_copy || !num2_str_copy) {
                free(num1_str_copy);
                free(num2_str_copy);
                return false;
            }

            if (check(num + j + 1, num1_str_copy, num2_str_copy)) {
                return true;
            }
        }
    }

    return false;
}