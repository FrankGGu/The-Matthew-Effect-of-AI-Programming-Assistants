#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findMissingAndRepeating(int* arr, int n, int* res) {
    int missing = 0, repeating = 0;
    long long sum = 0, sqSum = 0;
    for (int i = 0; i < n; i++) {
        sum += (long long)arr[i];
        sqSum += (long long)arr[i] * (long long)arr[i];
    }

    long long nSum = (long long)n * (n + 1) / 2;
    long long nSqSum = (long long)n * (n + 1) * (2 * n + 1) / 6;

    long long diff = sum - nSum;
    long long sqDiff = sqSum - nSqSum;

    long long sumMissingRepeating = sqDiff / diff;

    repeating = (int)((diff + sumMissingRepeating) / 2);
    missing = (int)(sumMissingRepeating - repeating);

    res[0] = repeating;
    res[1] = missing;

    return res;
}