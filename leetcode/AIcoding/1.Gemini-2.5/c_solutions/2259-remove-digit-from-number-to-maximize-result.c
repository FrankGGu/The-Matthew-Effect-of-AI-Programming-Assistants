#include <string.h>
#include <stdlib.h>

char* removeDigit(char* number, char digit) {
    int n = strlen(number);
    char* max_result = (char*)malloc(sizeof(char) * n);
    max_result[0] = '\0';

    char current_result_buffer[101];

    for (int i = 0; i < n; i++) {
        if (number[i] == digit) {
            int k = 0;
            for (int j = 0; j < i; j++) {
                current_result_buffer[k++] = number[j];
            }
            for (int j = i + 1; j < n; j++) {
                current_result_buffer[k++] = number[j];
            }
            current_result_buffer[k] = '\0';

            if (max_result[0] == '\0' || strcmp(current_result_buffer, max_result) > 0) {
                strcpy(max_result, current_result_buffer);
            }
        }
    }

    return max_result;
}