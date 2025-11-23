void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int partition(int* nums, int left, int right) {
    int pivot = nums[right];
    int i = left;
    for (int j = left; j < right; j++) {
        if (nums[j] >= pivot) {
            swap(&nums[i], &nums[j]);
            i++;
        }
    }
    swap(&nums[i], &nums[right]);
    return i;
}

int findKthLargest(int* nums, int numsSize, int k) {
    int left = 0, right = numsSize - 1;
    while (left <= right) {
        int pivotIndex = partition(nums, left, right);
        if (pivotIndex == k - 1) {
            return nums[pivotIndex];
        } else if (pivotIndex < k - 1) {
            left = pivotIndex + 1;
        } else {
            right = pivotIndex - 1;
        }
    }
    return -1;
}