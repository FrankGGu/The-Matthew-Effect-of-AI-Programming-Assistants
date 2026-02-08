int minOperations(int* nums, int numsSize, int x) {
    int totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }

    int targetSumSubarray = totalSum - x;

    // If targetSumSubarray is negative, it means x is greater than totalSum,
    // which is impossible to achieve by removing elements.
    if (targetSumSubarray < 0) {
        return -1;
    }

    int max_len = -1; // Stores the maximum length of the subarray with targetSumSubarray
    int left = 0;
    int current_sum = 0;

    for (int right = 0; right < numsSize; right++) {
        current_sum += nums[right];

        // Shrink the window from the left if current_sum exceeds targetSumSubarray
        // or if left pointer has crossed right pointer (invalid window)
        while (current_sum > targetSumSubarray && left <= right) {
            current_sum -= nums[left];
            left++;
        }

        // If current_sum equals targetSumSubarray, update max_len
        if (current_sum == targetSumSubarray) {
            if (right - left + 1 > max_len) {
                max_len = right - left + 1;
            }
        }
    }

    // If no subarray with targetSumSubarray was found
    if (max_len == -1) {
        return -1;
    } else {
        return numsSize - max_len;
    }
}