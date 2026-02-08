#include <stdlib.h>
#include <stdbool.h>

int compare(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

bool check(int* price, int priceSize, int k, int tastiness) {
    int count = 1;
    int prev_price = price[0];
    for (int i = 1; i < priceSize; i++) {
        if (price[i] - prev_price >= tastiness) {
            count++;
            prev_price = price[i];
            if (count == k) {
                return true;
            }
        }
    }
    return false;
}

int maximumTastiness(int* price, int priceSize, int k) {
    qsort(price, priceSize, sizeof(int), compare);

    int left = 0;
    int right = price[priceSize - 1] - price[0];
    int ans = 0;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (check(price, priceSize, k, mid)) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return ans;
}