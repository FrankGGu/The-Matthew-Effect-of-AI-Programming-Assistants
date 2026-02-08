#include <stdlib.h>
#include <string.h>

char* maximumOddBinaryNumber(char* s) {
    int n = strlen(s);
    int ones_count = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == '1') {
            ones_count++;
        }
    }

    char* result = (char*)malloc(sizeof(char) * (n + 1));

    int current_idx = 0;

    // Place (ones_count - 1) '1's at the beginning
    for (int i = 0; i < ones_count - 1; i++) {
        result[current_idx++] = '1';
    }

    // Place (n - ones_count) '0's after the initial '1's
    for (int i = 0; i < n - ones_count; i++) {
        result[current_idx++] = '0';
    }

    // Place the last '1' at the end
    result[current_idx++] = '1';

    // Null terminate the string
    result[current_idx] = '\0';

    return result;
}