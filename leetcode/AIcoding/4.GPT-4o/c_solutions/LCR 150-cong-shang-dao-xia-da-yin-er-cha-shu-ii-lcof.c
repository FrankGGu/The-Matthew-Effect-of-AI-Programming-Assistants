int minOperations(int* nums, int numsSize) {
    int max_count = 0;
    int count[101] = {0}; // Assuming nums[i] is in the range [1, 100]

    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
        if (count[nums[i]] > max_count) {
            max_count = count[nums[i]];
        }
    }

    return numsSize - max_count;
}