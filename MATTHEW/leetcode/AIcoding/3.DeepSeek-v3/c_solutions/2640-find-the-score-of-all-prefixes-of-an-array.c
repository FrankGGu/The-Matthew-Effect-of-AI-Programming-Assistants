/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
long long* findPrefixScore(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    long long* res = (long long*)malloc(numsSize * sizeof(long long));
    int max = nums[0];
    res[0] = nums[0] + max;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > max) {
            max = nums[i];
        }
        res[i] = res[i-1] + nums[i] + max;
    }

    return res;
}