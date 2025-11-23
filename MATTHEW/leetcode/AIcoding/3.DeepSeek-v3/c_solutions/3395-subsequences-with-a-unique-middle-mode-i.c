/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* subsequencesWithUniqueMiddleMode(int* nums, int numsSize, int* returnSize) {
    int n = numsSize;
    int* res = malloc(n * sizeof(int));
    *returnSize = n;

    for (int len = 1; len <= n; len++) {
        int count = 0;
        for (int i = 0; i <= n - len; i++) {
            int j = i + len - 1;
            int mid = (i + j) / 2;
            int mode = nums[mid];
            int freq = 0;
            for (int k = i; k <= j; k++) {
                if (nums[k] == mode) {
                    freq++;
                }
            }
            int unique = 1;
            for (int k = i; k <= j; k++) {
                if (nums[k] != mode) {
                    int other_freq = 0;
                    for (int l = i; l <= j; l++) {
                        if (nums[l] == nums[k]) {
                            other_freq++;
                        }
                    }
                    if (other_freq >= freq) {
                        unique = 0;
                        break;
                    }
                }
            }
            if (unique) {
                count++;
            }
        }
        res[len - 1] = count;
    }

    return res;
}