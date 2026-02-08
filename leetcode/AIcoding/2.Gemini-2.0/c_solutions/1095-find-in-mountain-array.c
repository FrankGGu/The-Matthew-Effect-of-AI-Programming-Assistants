#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findInMountainArray(int target, struct MountainArray *mountainArr) {
    int len = mountainArr->length(mountainArr);
    int peakIndex = 0;
    int left = 0;
    int right = len - 1;

    while (left < right) {
        int mid = left + (right - left) / 2;
        if (mountainArr->get(mountainArr, mid) < mountainArr->get(mountainArr, mid + 1)) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    peakIndex = left;

    left = 0;
    right = peakIndex;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        int val = mountainArr->get(mountainArr, mid);
        if (val == target) {
            return mid;
        } else if (val < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    left = peakIndex + 1;
    right = len - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        int val = mountainArr->get(mountainArr, mid);
        if (val == target) {
            return mid;
        } else if (val < target) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return -1;
}