int numberOfSubarrays(int* nums, int numsSize, int k) {
    int count = 0, left = 0, right = 0, oddCount = 0;

    while (right < numsSize) {
        if (nums[right] % 2 != 0) {
            oddCount++;
        }

        while (oddCount > k) {
            if (nums[left] % 2 != 0) {
                oddCount--;
            }
            left++;
        }

        if (oddCount == k) {
            int tempLeft = left;
            while (tempLeft < numsSize && nums[tempLeft] % 2 == 0) {
                tempLeft++;
            }
            int tempRight = right;
            while (tempRight >= 0 && nums[tempRight] % 2 == 0) {
                tempRight--;
            }
            count += (tempLeft - left + 1) * (right - tempRight + 1);
        }

        right++;
    }

    return count;
}