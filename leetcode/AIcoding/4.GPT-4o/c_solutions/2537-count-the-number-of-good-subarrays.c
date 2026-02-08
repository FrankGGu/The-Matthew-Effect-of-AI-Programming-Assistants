int countGood(int* nums, int numsSize, int k) {
    int count = 0, left = 0, right = 0, currentK = 0;
    int freq[100001] = {0};

    while (right < numsSize) {
        freq[nums[right]]++;
        if (freq[nums[right]] == 2) {
            currentK++;
        }

        while (currentK >= k) {
            freq[nums[left]]--;
            if (freq[nums[left]] == 1) {
                currentK--;
            }
            left++;
        }

        count += left;
        right++;
    }

    return count;
}