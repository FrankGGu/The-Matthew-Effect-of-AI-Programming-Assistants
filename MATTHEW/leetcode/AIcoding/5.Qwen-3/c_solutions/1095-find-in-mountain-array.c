#include <stdio.h>
#include <stdlib.h>

int findInMountainArray(int target, int* mountainArr, int mountainArrSize);

int findInMountainArray(int target, int* mountainArr, int mountainArrSize) {
    int left = 0, right = mountainArrSize - 1;
    int peak = 0;

    // Find the peak element
    while (left < right) {
        int mid = left + (right - left) / 2;
        if (mountainArr[mid] < mountainArr[mid + 1]) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    peak = left;

    // Search in the increasing part
    left = 0;
    right = peak;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (mountainArr[mid] == target) {
            return mid;
        } else if (mountainArr[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    // Search in the decreasing part
    left = peak;
    right = mountainArrSize - 1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (mountainArr[mid] == target) {
            return mid;
        } else if (mountainArr[mid] < target) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return -1;
}