int minimumOperations(int* nums, int numsSize) {
    int uniqueCount = 0;
    int seen[101] = {0}; // Assuming nums[i] is in the range [0, 100]

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0 && !seen[nums[i]]) {
            seen[nums[i]] = 1;
            uniqueCount++;
        }
    }

    return uniqueCount;
}