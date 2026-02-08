#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* findString(int n, int k) {
    char* result = (char*)malloc((n + 1) * sizeof(char));
    result[n] = '\0';

    for (int i = 0; i < n; i++) {
        result[i] = 'a' + (k % 26);
        k /= 26;
    }

    return result;
}