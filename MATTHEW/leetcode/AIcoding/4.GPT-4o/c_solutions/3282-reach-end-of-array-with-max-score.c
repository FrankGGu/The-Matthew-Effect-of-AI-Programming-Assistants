int maxScore(int* nums, int numsSize) {
    long long max_sum = 0, curr_sum = 0;
    for (int i = 0; i < numsSize; i++) {
        curr_sum += nums[i];
        if (curr_sum > max_sum) {
            max_sum = curr_sum;
        }
    }
    return (int)max_sum;
}