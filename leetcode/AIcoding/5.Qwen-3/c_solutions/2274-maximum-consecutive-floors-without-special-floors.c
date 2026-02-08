#include <stdio.h>
#include <stdlib.h>

int maxConsecutive(int n, int special[], int specialSize) {
    if (specialSize == 0) {
        return n;
    }

    qsort(special, specialSize, sizeof(int), (int (*)(const void*, const void*))strcmp);

    int max = 0;
    int prev = 0;

    for (int i = 0; i < specialSize; i++) {
        max = (max > (special[i] - prev - 1)) ? max : (special[i] - prev - 1);
        prev = special[i];
    }

    max = (max > (n - prev)) ? max : (n - prev);

    return max;
}