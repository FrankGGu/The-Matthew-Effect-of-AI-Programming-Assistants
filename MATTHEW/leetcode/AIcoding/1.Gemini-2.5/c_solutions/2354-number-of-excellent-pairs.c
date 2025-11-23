#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int lower_bound(int* arr, int size, int target) {
    int low = 0;
    int high = size;
    while (low < high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] < target) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }
    return low;
}

long long numberOfExcellentPairs(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), compare);

    long long ans = 0;

    for (int i = 0; i < numsSize; i++) {
        int target = k - nums[i];
        int idx = lower_bound(nums, numsSize, target);
        ans += (long long)(numsSize - idx);
    }

    return ans;
}