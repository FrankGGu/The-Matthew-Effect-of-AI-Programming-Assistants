int incremovableSubarrayCount(int* nums, int numsSize) {
    int left = 0;
    while (left + 1 < numsSize && nums[left] < nums[left + 1]) {
        left++;
    }

    if (left == numsSize - 1) {
        return numsSize * (numsSize + 1) / 2;
    }

    int right = numsSize - 1;
    while (right > 0 && nums[right - 1] < nums[right]) {
        right--;
    }

    long long result = left + 2;
    for (int i = 0; i <= left; i++) {
        while (right < numsSize && nums[i] >= nums[right]) {
            right++;
        }
        result += numsSize - right + 1;
    }

    return result;
}