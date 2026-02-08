#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxValue(int n, int index, int maxSum) {
    int left = 1, right = maxSum;
    int result = 0;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        long long sum = mid;

        if (index < mid - 1) {
            sum += (long long)(mid - 1 + mid - index) * index / 2;
        } else {
            sum += (long long)(mid - 1 + 1) * (mid - 1) / 2;
            sum += index - (mid - 1);
        }

        if (n - 1 - index < mid - 1) {
            sum += (long long)(mid - 1 + mid - (n - 1 - index)) * (n - 1 - index) / 2;
        } else {
            sum += (long long)(mid - 1 + 1) * (mid - 1) / 2;
            sum += (n - 1 - index) - (mid - 1);
        }

        sum -= (mid - 1);

        if (sum <= maxSum) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
}