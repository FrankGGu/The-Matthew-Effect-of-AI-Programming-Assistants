/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* mostCompetitive(int* nums, int numsSize, int k, int* returnSize) {
    int* stack = (int*)malloc(k * sizeof(int));
    int top = 0;
    int remaining = numsSize - k;

    for (int i = 0; i < numsSize; i++) {
        while (top > 0 && stack[top - 1] > nums[i] && remaining > 0) {
            top--;
            remaining--;
        }
        if (top < k) {
            stack[top++] = nums[i];
        } else {
            remaining--;
        }
    }

    *returnSize = k;
    return stack;
}