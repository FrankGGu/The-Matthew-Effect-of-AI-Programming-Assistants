int getMaximumGenerated(int n) {
    if (n == 0) return 0;
    if (n == 1) return 1;

    int *nums = (int *)malloc((n + 1) * sizeof(int));
    nums[0] = 0;
    nums[1] = 1;
    int max_num = 1;

    for (int i = 2; i <= n; i++) {
        if (i % 2 == 0) {
            nums[i] = nums[i / 2];
        } else {
            nums[i] = nums[i / 2] + nums[i / 2 + 1];
        }
        if (nums[i] > max_num) {
            max_num = nums[i];
        }
    }

    free(nums);
    return max_num;
}