#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int check(int mid, int n, int* quantities, int quantitiesSize) {
    long long count = 0;
    for (int i = 0; i < quantitiesSize; i++) {
        count += (long long)(quantities[i] + mid - 1) / mid;
    }
    return count <= n;
}

int minimizedMaximum(int n, int* quantities, int quantitiesSize) {
    int left = 1, right = 0;
    for (int i = 0; i < quantitiesSize; i++) {
        if (quantities[i] > right) {
            right = quantities[i];
        }
    }

    int ans = right;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (check(mid, n, quantities, quantitiesSize)) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    return ans;
}