#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int trailingZeroes(int n) {
    int count = 0;
    while (n > 0) {
        n /= 5;
        count += n;
    }
    return count;
}

int preimageSize(int k) {
    int low = 0;
    int high = 5 * k;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        int zeroes = trailingZeroes(mid);
        if (zeroes == k) {
            int temp = mid;
            while (trailingZeroes(temp) == k) {
                temp--;
            }
            int start = temp + 1;
            temp = mid;
            while (trailingZeroes(temp) == k) {
                temp++;
            }
            int end = temp - 1;
            return end - start + 1;
        } else if (zeroes < k) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return 0;
}