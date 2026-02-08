#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* getSmallestString(int n, int k) {
    char* result = (char*)malloc((n + 1) * sizeof(char));
    memset(result, 'a', n);
    int remaining = k - n;
    for (int i = n - 1; i >= 0 && remaining > 0; i--) {
        int add = (remaining > 25) ? 25 : remaining;
        result[i] += add;
        remaining -= add;
    }
    result[n] = '\0';
    return result;
}