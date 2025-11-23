int subarraySum(int* nums, int numsSize, int k) {
    int count = 0;
    int sum = 0;

    for (int start = 0; start < numsSize; start++) {
        sum = 0;
        for (int end = start; end < numsSize; end++) {
            sum += nums[end];
            if (sum == k) {
                count++;
            }
        }
    }

    return count;
}