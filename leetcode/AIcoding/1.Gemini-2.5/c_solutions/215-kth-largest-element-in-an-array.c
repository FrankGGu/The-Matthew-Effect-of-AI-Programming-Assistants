#include <stdlib.h> // Required for general utility functions if needed, but not strictly for this quickselect implementation.

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int partition(int* nums, int low, int high) {
    int pivot = nums[high];
    int i = low;

    for (int j = low; j < high; j++) {
        if (nums[j] <= pivot) {
            swap(&nums[i], &nums[j]);
            i++;
        }
    }
    swap(&nums[i], &nums[high]);
    return i;
}

int quickSelect(int* nums, int low, int high, int k_smallest_index) {
    if (low == high) {
        return nums[low];
    }

    int pivotIndex = partition(nums, low, high);

    if (pivotIndex == k_smallest_index) {
        return nums[pivotIndex];
    } else if (pivotIndex < k_smallest_index) {
        return quickSelect(nums, pivotIndex + 1, high, k_smallest_index);
    } else {
        return quickSelect(nums, low, pivotIndex - 1, k_smallest_index);
    }
}

int findKthLargest(int* nums, int numsSize, int k) {
    int k_smallest_index = numsSize - k;
    return quickSelect(nums, 0, numsSize - 1, k_smallest_index);
}