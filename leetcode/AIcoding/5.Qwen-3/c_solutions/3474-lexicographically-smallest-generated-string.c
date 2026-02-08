#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* getSmallestString(int n, int k) {
    char* result = (char*)malloc((n + 1) * sizeof(char));
    int i;
    for (i = 0; i < n; i++) {
        result[i] = 'a';
    }
    result[n] = '\0';
    int remaining = k - n;
    for (i = n - 1; i >= 0 && remaining > 0; i--) {
        int add = (remaining > 25) ? 25 : remaining;
        result[i] += add;
        remaining -= add;
    }
    return result;
}