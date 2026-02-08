int maxOperations(int* nums, int numsSize, int k) {
    int count = 0;
    int freq[100001] = {0};

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < k) {
            freq[nums[i]]++;
        }
    }

    for (int i = 1; i < k; i++) {
        if (freq[i] > 0 && freq[k - i] > 0) {
            if (i == k - i) {
                count += freq[i] / 2;
            } else {
                count += freq[i] < freq[k - i] ? freq[i] : freq[k - i];
            }
        }
    }

    return count;
}