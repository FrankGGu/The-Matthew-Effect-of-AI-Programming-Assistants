int countGood(int* nums, int numsSize, int k) {
    long long res = 0;
    int left = 0;
    long long pairs = 0;
    int freq[100001] = {0};

    for (int right = 0; right < numsSize; right++) {
        pairs += freq[nums[right]];
        freq[nums[right]]++;

        while (pairs >= k) {
            res += numsSize - right;
            freq[nums[left]]--;
            pairs -= freq[nums[left]];
            left++;
        }
    }

    return res;
}