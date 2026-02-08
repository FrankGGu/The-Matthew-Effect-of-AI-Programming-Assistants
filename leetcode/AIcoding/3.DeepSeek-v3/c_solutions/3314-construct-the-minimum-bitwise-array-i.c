/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* minBitwiseArray(int* nums, int numsSize, int* returnSize) {
    int* ans = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            ans[i] = -1;
        } else {
            int x = 0;
            while ((nums[i] & (1 << x)) == 0) {
                x++;
            }
            ans[i] = (1 << x);
        }
    }

    return ans;
}