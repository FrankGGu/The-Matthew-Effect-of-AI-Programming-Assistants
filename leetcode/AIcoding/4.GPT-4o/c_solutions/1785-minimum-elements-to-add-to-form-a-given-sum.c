int minElements(int* nums, int numsSize, int limit, int goal) {
    long long sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    long long target = goal - sum;
    if (target == 0) return 0;
    long long absTarget = labs(target);
    return (absTarget + limit - 1) / limit;
}