#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool check(int mid, int* nums, int numsSize, int* changeIndices, int changeIndicesSize) {
    int last[numsSize + 1];
    for (int i = 1; i <= numsSize; i++) {
        last[i] = -1;
    }

    for (int i = 0; i < mid; i++) {
        last[changeIndices[i]] = i;
    }

    for (int i = 1; i <= numsSize; i++) {
        if (last[i] == -1) {
            return false;
        }
    }

    int time = 0;
    for (int i = 0; i < mid; i++) {
        int index = changeIndices[i];
        if (last[index] == i) {
            if (nums[index - 1] <= time) {
                time -= nums[index - 1];
                if (time < 0) time = 0;
                time++;
            } else {
                time++;
            }
        } else {
            time++;
        }
    }

    return true;
}

int earliestSecondToMarkIndices(int* nums, int numsSize, int* changeIndices, int changeIndicesSize) {
    int left = 1, right = changeIndicesSize;
    int ans = -1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (check(mid, nums, numsSize, changeIndices, changeIndicesSize)) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
}