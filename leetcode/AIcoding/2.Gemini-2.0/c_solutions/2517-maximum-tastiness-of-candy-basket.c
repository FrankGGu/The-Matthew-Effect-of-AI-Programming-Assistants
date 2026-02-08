#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

int count(int *price, int n, int tastiness) {
    int cnt = 1;
    int prev = price[0];
    for (int i = 1; i < n; i++) {
        if (price[i] - prev >= tastiness) {
            cnt++;
            prev = price[i];
        }
    }
    return cnt;
}

int maximumTastiness(int* price, int priceSize, int k){
    qsort(price, priceSize, sizeof(int), cmp);
    int left = 0, right = price[priceSize - 1] - price[0];
    int ans = 0;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (count(price, priceSize, mid) >= k) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return ans;
}