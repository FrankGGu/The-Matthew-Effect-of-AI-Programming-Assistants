#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long min(long long a, long long b) {
    return a < b ? a : b;
}

long long calculateTime(int* piles, int pilesSize, long long h) {
    long long time = 0;
    for (int i = 0; i < pilesSize; i++) {
        time += (piles[i] + h - 1) / h;
    }
    return time;
}

int minEatingSpeed(int* piles, int pilesSize, int h) {
    qsort(piles, pilesSize, sizeof(int), compare);
    long long left = 1;
    long long right = piles[0];
    long long answer = right;

    while (left <= right) {
        long long mid = (left + right) / 2;
        long long time = calculateTime(piles, pilesSize, mid);
        if (time <= h) {
            answer = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return (int)answer;
}