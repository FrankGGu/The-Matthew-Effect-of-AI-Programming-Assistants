#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool queryString(char *s, int n) {
    if (n > 1000) {
        return false;
    }

    for (int i = 1; i <= n; i++) {
        char binary[11];
        int temp = i;
        int index = 0;

        while (temp > 0) {
            binary[index++] = (temp % 2) + '0';
            temp /= 2;
        }
        binary[index] = '\0';

        for (int j = 0, k = index - 1; j < k; j++, k--) {
            char tempChar = binary[j];
            binary[j] = binary[k];
            binary[k] = tempChar;
        }

        if (strstr(s, binary) == NULL) {
            return false;
        }
    }

    return true;
}