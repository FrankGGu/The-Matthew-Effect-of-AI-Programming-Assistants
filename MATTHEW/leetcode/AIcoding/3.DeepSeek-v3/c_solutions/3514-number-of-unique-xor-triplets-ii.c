int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int countUniqueTriplets(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmp);

    int res = 0;
    for (int i = 0; i < numsSize; i++) {
        if (i > 0 && nums[i] == nums[i - 1]) continue;

        int j = i + 1, k = numsSize - 1;
        while (j < k) {
            int xor_val = nums[i] ^ nums[j] ^ nums[k];

            if (xor_val == 0) {
                res++;
                j++;
                k--;
                while (j < k && nums[j] == nums[j - 1]) j++;
                while (j < k && nums[k] == nums[k + 1]) k--;
            } else if (xor_val < 0) {
                k--;
            } else {
                j++;
            }
        }
    }
    return res;
}