int minOperations(int* nums, int numsSize, int k) {
    int freq[51] = {0};
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    int operations = 0;
    for (int i = 1; i <= 50; i++) {
        if (freq[i] > 0 && i < k) {
            operations += freq[i];
        }
    }
    return operations;
}