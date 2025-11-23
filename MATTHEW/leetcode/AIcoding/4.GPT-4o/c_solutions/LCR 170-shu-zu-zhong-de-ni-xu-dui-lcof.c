int merge(int* nums, int left, int mid, int right) {
    int* temp = (int*)malloc((right - left + 1) * sizeof(int));
    int i = left, j = mid + 1, k = 0;
    int count = 0;

    while (i <= mid && j <= right) {
        if (nums[i] <= nums[j]) {
            temp[k++] = nums[i++];
        } else {
            temp[k++] = nums[j++];
            count += (mid - i + 1);
        }
    }

    while (i <= mid) {
        temp[k++] = nums[i++];
    }
    while (j <= right) {
        temp[k++] = nums[j++];
    }

    for (i = left; i <= right; i++) {
        nums[i] = temp[i - left];
    }

    free(temp);
    return count;
}

int mergeSort(int* nums, int left, int right) {
    if (left >= right) return 0;
    int mid = left + (right - left) / 2;
    return mergeSort(nums, left, mid) + mergeSort(nums, mid + 1, right) + merge(nums, left, mid, right);
}

int reversePairs(int* nums, int numsSize) {
    return mergeSort(nums, 0, numsSize - 1);
}