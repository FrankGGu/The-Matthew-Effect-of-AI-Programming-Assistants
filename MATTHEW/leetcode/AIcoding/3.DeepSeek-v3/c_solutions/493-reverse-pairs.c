int mergeSort(int* nums, int left, int right) {
    if (left >= right) return 0;

    int mid = left + (right - left) / 2;
    int count = mergeSort(nums, left, mid) + mergeSort(nums, mid + 1, right);

    int j = mid + 1;
    for (int i = left; i <= mid; i++) {
        while (j <= right && nums[i] > 2LL * nums[j]) {
            j++;
        }
        count += j - (mid + 1);
    }

    int* temp = (int*)malloc((right - left + 1) * sizeof(int));
    int i = left, k = 0;
    j = mid + 1;

    while (i <= mid && j <= right) {
        if (nums[i] <= nums[j]) {
            temp[k++] = nums[i++];
        } else {
            temp[k++] = nums[j++];
        }
    }

    while (i <= mid) temp[k++] = nums[i++];
    while (j <= right) temp[k++] = nums[j++];

    for (int p = 0; p < k; p++) {
        nums[left + p] = temp[p];
    }

    free(temp);
    return count;
}

int reversePairs(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    return mergeSort(nums, 0, numsSize - 1);
}