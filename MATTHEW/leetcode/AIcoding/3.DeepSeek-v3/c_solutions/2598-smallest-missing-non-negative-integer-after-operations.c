int findSmallestInteger(int* nums, int numsSize, int value) {
    int* count = (int*)calloc(value, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        int mod = (nums[i] % value + value) % value;
        count[mod]++;
    }

    int mex = 0;
    while (count[mex % value] > 0) {
        count[mex % value]--;
        mex++;
    }

    free(count);
    return mex;
}