/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int tupleSameProduct(int* nums, int numsSize) {
    int count = 0;
    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) max_val = nums[i];
    }

    int* freq = (int*)calloc(max_val * max_val + 1, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            int product = nums[i] * nums[j];
            freq[product]++;
        }
    }

    for (int i = 0; i <= max_val * max_val; i++) {
        if (freq[i] > 1) {
            count += freq[i] * (freq[i] - 1) / 2 * 8;
        }
    }

    free(freq);
    return count;
}