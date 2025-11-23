#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int nthUglyNumber(int n) {
    int *ugly = (int*)malloc(sizeof(int) * n);
    ugly[0] = 1;
    int i2 = 0, i3 = 0, i5 = 0;
    int next_multiple_of_2 = 2;
    int next_multiple_of_3 = 3;
    int next_multiple_of_5 = 5;

    for (int i = 1; i < n; i++) {
        int min = next_multiple_of_2;
        if (next_multiple_of_3 < min)
            min = next_multiple_of_3;
        if (next_multiple_of_5 < min)
            min = next_multiple_of_5;

        ugly[i] = min;

        if (min == next_multiple_of_2) {
            i2++;
            next_multiple_of_2 = ugly[i2] * 2;
        }
        if (min == next_multiple_of_3) {
            i3++;
            next_multiple_of_3 = ugly[i3] * 3;
        }
        if (min == next_multiple_of_5) {
            i5++;
            next_multiple_of_5 = ugly[i5] * 5;
        }
    }

    int result = ugly[n - 1];
    free(ugly);
    return result;
}