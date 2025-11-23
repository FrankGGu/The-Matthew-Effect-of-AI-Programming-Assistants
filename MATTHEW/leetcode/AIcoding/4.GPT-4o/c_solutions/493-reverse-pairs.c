int merge(int* nums, int left, int mid, int right) {
    int count = 0;
    int j = mid + 1;
    for (int i = left; i <= mid; i++) {
        while (j <= right && nums[i] > 2LL * nums[j]) {
            j++;
        }
        count += j - (mid + 1);
    }

    int* temp = malloc((right - left + 1) * sizeof(int));
    int k = 0, p1 = left, p2 = mid + 1;

    while (p1 <= mid && p2 <= right) {
        if (nums[p1] <= nums[p2]) {
            temp[k++] = nums[p1++];
        } else {
            temp[k++] = nums[p2++];
        }
    }

    while (p1 <= mid) {
        temp[k++] = nums[p1++];
    }

    while (p2 <= right) {
        temp[k++] = nums[p2++];
    }

    for (int i = 0; i < k; i++) {
        nums[left + i] = temp[i];
    }

    free(temp);
    return count;
}

int mergeSort(int* nums, int left, int right) {
    if (left >= right) return 0;
    int mid = left + (right - left) / 2;
    int count = mergeSort(nums, left, mid) + mergeSort(nums, mid + 1, right);
    count += merge(nums, left, mid, right);
    return count;
}

int reversePairs(int* nums, int numsSize) {
    return mergeSort(nums, 0, numsSize - 1);
}