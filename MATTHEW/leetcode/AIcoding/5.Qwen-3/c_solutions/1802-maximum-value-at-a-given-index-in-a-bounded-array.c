#include <stdio.h>
#include <stdlib.h>

int maxValue(int n, int index, int maxSum) {
    int left = 1, right = maxSum;
    int result = 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        long long total = 0;
        int leftCount = index;
        int rightCount = n - index - 1;

        if (leftCount > 0) {
            int a1 = mid - 1;
            int an = mid - leftCount;
            if (an < 1) {
                total += (long long)(a1 + 1) * leftCount / 2;
                total += (long long)(1 - an) * (long long)(leftCount - (mid - 1));
            } else {
                total += (long long)(a1 + an) * leftCount / 2;
            }
        }

        if (rightCount > 0) {
            int a1 = mid - 1;
            int an = mid - rightCount;
            if (an < 1) {
                total += (long long)(a1 + 1) * rightCount / 2;
                total += (long long)(1 - an) * (long long)(rightCount - (mid - 1));
            } else {
                total += (long long)(a1 + an) * rightCount / 2;
            }
        }

        total += mid;

        if (total <= maxSum) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
}