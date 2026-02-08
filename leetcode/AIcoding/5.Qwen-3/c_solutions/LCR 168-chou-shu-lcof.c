#include <stdio.h>
#include <stdlib.h>

int nthUglyNumber(int n) {
    int* ugly = (int*)malloc(n * sizeof(int));
    int i2 = 0, i3 = 0, i5 = 0;
    int next2 = 2, next3 = 3, next5 = 5;
    ugly[0] = 1;

    for (int i = 1; i < n; i++) {
        ugly[i] = (int)fmin(fmin(next2, next3), next5);
        if (ugly[i] == next2) next2 = 2 * ugly[++i2];
        if (ugly[i] == next3) next3 = 3 * ugly[++i3];
        if (ugly[i] == next5) next5 = 5 * ugly[++i5];
    }

    int result = ugly[n - 1];
    free(ugly);
    return result;
}