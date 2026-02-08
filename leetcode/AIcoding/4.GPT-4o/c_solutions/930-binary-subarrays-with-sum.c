int numSubarraysWithSum(int* nums, int numsSize, int goal) {
    int count[numsSize + 1];
    memset(count, 0, sizeof(count));
    count[0] = 1;
    int sum = 0, result = 0;

    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
        if (sum >= goal) {
            result += count[sum - goal];
        }
        count[sum]++;
    }

    return result;
}