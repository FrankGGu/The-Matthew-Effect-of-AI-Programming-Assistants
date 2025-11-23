#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findKthNumber(int m, int n, int k) {
    int low = 1, high = m * n;
    while (low < high) {
        int mid = low + (high - low) / 2;
        int count = 0;
        for (int i = 1; i <= m; i++) {
            count += (mid / i) > n ? n : (mid / i);
        }
        if (count < k) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }
    return low;
}