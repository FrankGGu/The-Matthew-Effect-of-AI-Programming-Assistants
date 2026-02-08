#include <stdlib.h>
#include <stdbool.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

bool check(int x, int* price, int priceSize, int k) {
    int count = 1;
    int lastPickedPrice = price[0];

    for (int i = 1; i < priceSize; i++) {
        if (price[i] - lastPickedPrice >= x) {
            count++;
            lastPickedPrice = price[i];
        }
    }
    return count >= k;
}

int maximumTastiness(int* price, int priceSize, int k) {
    qsort(price, priceSize, sizeof(int), compare);

    int low = 0;
    int high = price[priceSize - 1] - price[0];
    int ans = 0;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (check(mid, price, priceSize, k)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
}