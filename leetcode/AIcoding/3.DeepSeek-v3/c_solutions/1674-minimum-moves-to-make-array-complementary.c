int minMoves(int* nums, int numsSize, int limit) {
    int n = numsSize;
    int *diff = (int *)calloc(2 * limit + 2, sizeof(int));

    for (int i = 0; i < n / 2; i++) {
        int a = nums[i];
        int b = nums[n - 1 - i];

        diff[2] += 2;
        diff[2 * limit + 1] -= 2;

        diff[1 + (a < b ? a : b)] -= 1;
        diff[limit + (a > b ? a : b) + 1] += 1;

        diff[a + b] -= 1;
        diff[a + b + 1] += 1;
    }

    int res = n;
    int curr = 0;
    for (int t = 2; t <= 2 * limit; t++) {
        curr += diff[t];
        if (curr < res) {
            res = curr;
        }
    }

    free(diff);
    return res;
}