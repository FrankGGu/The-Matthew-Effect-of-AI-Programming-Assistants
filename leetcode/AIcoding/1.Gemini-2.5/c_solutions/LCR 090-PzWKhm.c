#ifndef MAX
#define MAX(a, b) ((a) > (b) ? (a) : (b))
#endif

int robRange(int* nums, int start, int end) {
    int prev2 = 0;
    int prev1 = 0;

    for (int i = start; i <= end; i++) {
        int current = MAX(prev1, prev2 + nums[i]);
        prev2 = prev1;
        prev1 = current;
    }
    return prev1;
}

int rob(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }
    if (numsSize == 1) {
        return nums[0];
    }

    int result1 = robRange(nums, 0, numsSize - 2);
    int result2 = robRange(nums, 1, numsSize - 1);

    return MAX(result1, result2);
}