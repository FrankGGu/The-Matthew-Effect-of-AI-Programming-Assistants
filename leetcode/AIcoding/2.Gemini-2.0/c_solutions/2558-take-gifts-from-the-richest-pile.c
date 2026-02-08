#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long takeGifts(int* gifts, int giftsSize, int k) {
    for (int i = 0; i < k; i++) {
        int maxIndex = 0;
        for (int j = 1; j < giftsSize; j++) {
            if (gifts[j] > gifts[maxIndex]) {
                maxIndex = j;
            }
        }
        gifts[maxIndex] = (int)sqrt(gifts[maxIndex]);
    }

    long long sum = 0;
    for (int i = 0; i < giftsSize; i++) {
        sum += gifts[i];
    }

    return sum;
}