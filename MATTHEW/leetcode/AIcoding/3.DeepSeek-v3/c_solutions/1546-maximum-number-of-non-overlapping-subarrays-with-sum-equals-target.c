int maxNonOverlapping(int* nums, int numsSize, int target) {
    int count = 0;
    int sum = 0;
    int seen[200001] = {0};
    seen[100000] = 1;

    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
        if (seen[sum - target + 100000]) {
            count++;
            sum = 0;
            for (int j = 0; j < 200001; j++) seen[j] = 0;
            seen[100000] = 1;
        } else {
            seen[sum + 100000] = 1;
        }
    }

    return count;
}