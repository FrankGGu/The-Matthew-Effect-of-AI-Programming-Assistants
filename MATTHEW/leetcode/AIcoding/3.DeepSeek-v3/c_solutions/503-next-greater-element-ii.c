/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* nextGreaterElements(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    if (numsSize == 0) return NULL;

    int* result = (int*)malloc(numsSize * sizeof(int));
    int* stack = (int*)malloc(numsSize * sizeof(int));
    int top = -1;

    for (int i = 0; i < numsSize; i++) {
        result[i] = -1;
    }

    for (int i = 0; i < 2 * numsSize; i++) {
        int idx = i % numsSize;
        while (top != -1 && nums[stack[top]] < nums[idx]) {
            result[stack[top]] = nums[idx];
            top--;
        }
        if (i < numsSize) {
            stack[++top] = idx;
        }
    }

    free(stack);
    return result;
}