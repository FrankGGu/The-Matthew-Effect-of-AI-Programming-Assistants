#include <math.h>

long long pickGifts(int* gifts, int giftsSize, int k) {
    for (int i = 0; i < k; i++) {
        int max_index = 0;
        for (int j = 1; j < giftsSize; j++) {
            if (gifts[j] > gifts[max_index]) {
                max_index = j;
            }
        }
        gifts[max_index] = (int)sqrt(gifts[max_index]);
    }

    long long sum = 0;
    for (int i = 0; i < giftsSize; i++) {
        sum += gifts[i];
    }
    return sum;
}