/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* minBitwiseArray(int* nums, int numsSize, int* returnSize) {
    int* ans = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;

    for (int i = 0; i < numsSize; i++) {
        int x = nums[i];
        if (x == 1) {
            ans[i] = -1;
            continue;
        }

        int found = 0;
        for (int y = 1; y < x; y++) {
            if ((y | (y + 1)) == x) {
                ans[i] = y;
                found = 1;
                break;
            }
        }

        if (!found) {
            ans[i] = -1;
        }
    }

    return ans;
}