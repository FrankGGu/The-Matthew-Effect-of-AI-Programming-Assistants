int compare(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

int numSubseq(int* nums, int numsSize, int target) {
    qsort(nums, numsSize, sizeof(int), compare);

    int mod = 1000000007;
    int *pow2 = malloc(numsSize * sizeof(int));
    pow2[0] = 1;
    for (int i = 1; i < numsSize; i++) {
        pow2[i] = (pow2[i-1] * 2) % mod;
    }

    int left = 0, right = numsSize - 1;
    int count = 0;

    while (left <= right) {
        if (nums[left] + nums[right] <= target) {
            count = (count + pow2[right - left]) % mod;
            left++;
        } else {
            right--;
        }
    }

    free(pow2);
    return count;
}