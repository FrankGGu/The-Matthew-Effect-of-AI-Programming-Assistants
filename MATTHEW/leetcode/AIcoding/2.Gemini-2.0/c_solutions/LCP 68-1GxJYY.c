#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int beautifulBouquet(int* flowers, int flowersSize, int cnt) {
    long long left = 0, right = 0;
    long long sum = 0;
    for (int i = 0; i < flowersSize; i++) {
        sum += flowers[i];
    }
    right = sum;
    long long ans = right;
    while (left <= right) {
        long long mid = left + (right - left) / 2;
        int count = 1;
        long long currentSum = 0;
        for (int i = 0; i < flowersSize; i++) {
            if (flowers[i] > mid) {
                count = cnt + 1;
                break;
            }
            if (currentSum + flowers[i] <= mid) {
                currentSum += flowers[i];
            } else {
                count++;
                currentSum = flowers[i];
            }
        }
        if (count <= cnt) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    return ans;
}