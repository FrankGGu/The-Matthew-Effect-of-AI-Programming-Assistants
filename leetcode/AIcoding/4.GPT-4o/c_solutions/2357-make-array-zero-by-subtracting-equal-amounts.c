int minimumOperations(int* nums, int numsSize) {
    int count = 0;
    int seen[101] = {0};

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0 && !seen[nums[i]]) {
            seen[nums[i]] = 1;
            count++;
        }
    }

    return count;
}