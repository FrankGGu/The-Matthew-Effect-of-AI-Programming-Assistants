void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int partition(int* nums, int left, int right) {
    int pivot = nums[right];
    int i = left;

    for (int j = left; j < right; j++) {
        if (nums[j] <= pivot) {
            swap(&nums[i], &nums[j]);
            i++;
        }
    }
    swap(&nums[i], &nums[right]);
    return i;
}

int quickSelect(int* nums, int left, int right, int k_smallest_idx) {
    if (left == right) {
        return nums[left];
    }

    int pivot_idx = partition(nums, left, right);

    if (pivot_idx == k_smallest_idx) {
        return nums[pivot_idx];
    } else if (pivot_idx < k_smallest_idx) {
        return quickSelect(nums, pivot_idx + 1, right, k_smallest_idx);
    } else {
        return quickSelect(nums, left, pivot_idx - 1, k_smallest_idx);
    }
}

int findKthLargest(int* nums, int numsSize, int k) {
    int k_smallest_idx = numsSize - k;
    return quickSelect(nums, 0, numsSize - 1, k_smallest_idx);
}