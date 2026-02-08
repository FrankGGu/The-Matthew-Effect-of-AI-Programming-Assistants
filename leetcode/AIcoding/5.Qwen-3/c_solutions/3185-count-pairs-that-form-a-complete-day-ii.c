#include <stdio.h>
#include <stdlib.h>

long long countCompleteDayPairs(int* time, int timeSize, int k) {
    int* remainderCount = (int*)calloc(k, sizeof(int));
    long long count = 0;

    for (int i = 0; i < timeSize; i++) {
        int rem = time[i] % k;
        if (rem == 0) {
            count += remainderCount[0];
        } else {
            count += remainderCount[k - rem];
        }
        remainderCount[rem]++;
    }

    free(remainderCount);
    return count;
}