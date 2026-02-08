#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findKthLargest(int* nums, int numsSize, int k) {
    int partition(int* nums, int left, int right) {
        int pivot = nums[right];
        int i = left - 1;
        for (int j = left; j < right; j++) {
            if (nums[j] >= pivot) {
                i++;
                int temp = nums[i];
                nums[i] = nums[j];
                nums[j] = temp;
            }
        }
        int temp = nums[i + 1];
        nums[i + 1] = nums[right];
        nums[right] = temp;
        return i + 1;
    }

    int quickSelect(int* nums, int left, int right, int k) {
        if (left == right) {
            return nums[left];
        }
        int pivotIndex = partition(nums, left, right);
        int rank = pivotIndex - left + 1;
        if (k == rank) {
            return nums[pivotIndex];
        } else if (k < rank) {
            return quickSelect(nums, left, pivotIndex - 1, k);
        } else {
            return quickSelect(nums, pivotIndex + 1, right, k - rank);
        }
    }

    return quickSelect(nums, 0, numsSize - 1, k);
}