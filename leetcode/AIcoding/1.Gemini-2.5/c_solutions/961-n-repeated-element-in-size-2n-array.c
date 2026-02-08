int repeatedNElement(int* nums, int numsSize) {
    int freq[10001] = {0};

    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
        if (freq[nums[i]] == 2) {
            return nums[i];
        }
    }

    return -1;
}