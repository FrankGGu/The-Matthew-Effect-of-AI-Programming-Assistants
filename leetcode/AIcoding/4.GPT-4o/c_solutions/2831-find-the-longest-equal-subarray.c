int longestEqualSubarray(int* nums, int numsSize, int k) {
    int maxLength = 0;
    int count[101] = {0};
    int left = 0;

    for (int right = 0; right < numsSize; right++) {
        count[nums[right]]++;

        while (right - left + 1 - count[nums[right]] > k) {
            count[nums[left]]--;
            left++;
        }

        maxLength = fmax(maxLength, right - left + 1);
    }

    return maxLength;
}