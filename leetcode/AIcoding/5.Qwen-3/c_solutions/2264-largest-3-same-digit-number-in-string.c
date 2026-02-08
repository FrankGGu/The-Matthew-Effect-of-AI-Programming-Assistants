#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* largestGoodInteger(char* num) {
    int max_len = 0;
    char* result = (char*)malloc(4 * sizeof(char));
    result[0] = '\0';

    for (int i = 0; i < strlen(num) - 2; i++) {
        if (num[i] == num[i + 1] && num[i] == num[i + 2]) {
            int current_len = 3;
            if (current_len > max_len) {
                max_len = current_len;
                strncpy(result, &num[i], 3);
                result[3] = '\0';
            }
        }
    }

    return result;
}