#include <stdlib.h>
#include <string.h>

char* multiply(char* num1, char* num2) {
    if (strcmp(num1, "0") == 0 || strcmp(num2, "0") == 0) {
        char* result = (char*) malloc(sizeof(char) * 2);
        result[0] = '0';
        result[1] = '\0';
        return result;
    }

    int len1 = strlen(num1);
    int len2 = strlen(num2);
    int result_len = len1 + len2;

    int* ans = (int*) calloc(result_len, sizeof(int));

    for (int i = len1 - 1; i >= 0; i--) {
        for (int j = len2 - 1; j >= 0; j--) {
            int digit1 = num1[i] - '0';
            int digit2 = num2[j] - '0';

            int product = digit1 * digit2;

            int sum = ans[i + j + 1] + product;

            ans[i + j + 1] = sum % 10;
            ans[i + j] += sum / 10;
        }
    }

    int k = 0;
    while (k < result_len - 1 && ans[k] == 0) {
        k++;
    }

    char* result_str = (char*) malloc(sizeof(char) * (result_len - k + 1));

    int str_idx = 0;
    while (k < result_len) {
        result_str[str_idx++] = ans[k++] + '0';
    }
    result_str[str_idx] = '\0';

    free(ans);

    return result_str;
}