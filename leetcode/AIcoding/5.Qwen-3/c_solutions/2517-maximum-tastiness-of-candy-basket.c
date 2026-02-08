#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int maximumTastiness(int* price, int priceSize, int k) {
    qsort(price, priceSize, sizeof(int), compare);
    int minTastiness = 0;
    int maxTastiness = price[priceSize - 1] - price[0];

    while (minTastiness <= maxTastiness) {
        int mid = (minTastiness + maxTastiness) / 2;
        int count = 1;
        int prev = price[0];

        for (int i = 1; i < priceSize; i++) {
            if (price[i] - prev >= mid) {
                count++;
                prev = price[i];
            }
        }

        if (count >= k) {
            minTastiness = mid + 1;
        } else {
            maxTastiness = mid - 1;
        }
    }

    return maxTastiness;
}