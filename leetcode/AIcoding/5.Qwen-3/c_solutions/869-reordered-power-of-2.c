#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(char*)a - *(char*)b);
}

int isPowerOfTwo(long long x) {
    return (x != 0) && ((x & (x - 1)) == 0);
}

int reorderedPowerOf2(int n) {
    char numStr[16];
    sprintf(numStr, "%d", n);
    int len = strlen(numStr);
    qsort(numStr, len, sizeof(char), compare);

    for (int i = 0; i < 31; i++) {
        long long power = 1LL << i;
        char powerStr[16];
        sprintf(powerStr, "%lld", power);
        int powerLen = strlen(powerStr);
        qsort(powerStr, powerLen, sizeof(char), compare);

        if (strcmp(numStr, powerStr) == 0) {
            return 1;
        }
    }

    return 0;
}