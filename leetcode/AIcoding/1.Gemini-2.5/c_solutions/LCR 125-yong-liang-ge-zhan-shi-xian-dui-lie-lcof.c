#include <string.h>
#include <stdlib.h>

char* maximumBinaryString(char* binary) {
    int n = strlen(binary);
    int zeros = 0;
    int first_zero_idx = -1;

    for (int i = 0; i < n; i++) {
        if (binary[i] == '0') {
            zeros++;
            if (first_zero_idx == -1) {
                first_zero_idx = i;
            }
        }
    }

    if (zeros <= 1) {
        char* result = (char*)malloc(sizeof(char) * (n + 1));
        strcpy(result, binary);
        return result;
    }

    char* result = (char*)malloc(sizeof(char) * (n + 1));
    memset(result, '1', n);
    result[n] = '\0';

    result[first_zero_idx + zeros - 1] = '0';

    return result;
}