#include <stdlib.h> // Required for malloc and free

void merge(int* nums, int left, int mid, int right, int* temp) {
    int i = left;
    int j = mid + 1;
    int k = left;

    while (i <= mid && j <= right) {
        if (nums[i] <= nums[j]) {
            temp[k++] = nums[i++];
        } else {
            temp[k++] = nums[j++];
        }
    }

    while (i <= mid) {
        temp[k++] = nums[i++];
    }

    while (j <= right) {
        temp[k++] = nums[j++];
    }

    for (int l = left; l <= right; l++) {
        nums[l] = temp[l];
    }
}

void mergeSort(int* nums, int left, int right, int* temp) {
    if (left < right) {
        int mid = left + (right - left) / 2;
        mergeSort(nums, left, mid, temp);
        mergeSort(nums, mid + 1, right, temp);
        merge(nums, left, mid, right, temp);
    }
}

int* sortArray(int* nums, int numsSize, int* returnSize) {
    if (nums == NULL || numsSize <= 1) {
        *returnSize = numsSize;
        return nums;
    }

    int* temp = (int*)malloc(numsSize * sizeof(int));
    if (temp == NULL) {
        *returnSize = 0;
        return NULL; // Handle allocation failure
    }

    mergeSort(nums, 0, numsSize - 1, temp);

    free(temp);
    *returnSize = numsSize;
    return nums;
}