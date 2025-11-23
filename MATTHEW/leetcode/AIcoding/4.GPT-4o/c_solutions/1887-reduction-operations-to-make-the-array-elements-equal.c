int reductionOperations(int* nums, int numsSize) {
    int count = 0, operations = 0;
    int freq[100001] = {0};

    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    for (int i = 100000; i >= 0; i--) {
        if (freq[i] > 0) {
            operations += count * freq[i];
            count += freq[i];
        }
    }

    return operations;
}