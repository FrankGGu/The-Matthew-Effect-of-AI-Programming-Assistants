/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* targetIndices(int* nums, int numsSize, int target, int* returnSize) {
    int count = 0;
    int less = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < target) {
            less++;
        } else if (nums[i] == target) {
            count++;
        }
    }

    int* result = (int*)malloc(count * sizeof(int));
    *returnSize = count;

    for (int i = 0; i < count; i++) {
        result[i] = less + i;
    }

    return result;
}