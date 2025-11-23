#include <stdio.h>
#include <stdlib.h>

int findKthNumber(int m, int n, int k) {
    long long low = 1;
    long long high = m * n;

    while (low < high) {
        long long mid = (low + high) / 2;
        long long count = 0;

        for (int i = 1; i <= m; i++) {
            long long val = mid / i;
            if (val > n) {
                val = n;
            }
            count += val;
            if (count >= k) {
                break;
            }
        }

        if (count < k) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }

    return (int)low;
}