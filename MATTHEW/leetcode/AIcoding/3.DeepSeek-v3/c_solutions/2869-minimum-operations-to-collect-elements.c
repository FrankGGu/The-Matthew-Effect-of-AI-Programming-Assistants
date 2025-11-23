int minOperations(int* nums, int numsSize, int k) {
    int found[51] = {0};
    int count = 0;
    int total = 0;

    for (int i = numsSize - 1; i >= 0; i--) {
        total++;
        if (nums[i] <= k && found[nums[i]] == 0) {
            found[nums[i]] = 1;
            count++;
            if (count == k) {
                return total;
            }
        }
    }
    return total;
}