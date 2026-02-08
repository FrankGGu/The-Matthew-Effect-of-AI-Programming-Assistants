#include <stdio.h>
#include <stdlib.h>

int* earliestAndLatest(int n, int a, int b, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    int left = 1;
    int right = n;
    int round = 0;

    while (left < right) {
        round++;
        int mid = (left + right) / 2;
        if (a <= mid && b > mid) {
            break;
        } else if (a > mid) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    result[0] = round;

    left = 1;
    right = n;
    round = 0;

    while (left < right) {
        round++;
        int mid = (left + right) / 2;
        if (a <= mid && b > mid) {
            break;
        } else if (a > mid) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    result[1] = round;

    return result;
}