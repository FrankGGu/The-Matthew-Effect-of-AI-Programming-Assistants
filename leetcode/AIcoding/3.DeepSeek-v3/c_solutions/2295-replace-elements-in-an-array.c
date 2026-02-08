/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* arrayChange(int* nums, int numsSize, int** operations, int operationsSize, int* operationsColSize, int* returnSize) {
    int pos[1000001] = {0};

    for (int i = 0; i < numsSize; i++) {
        pos[nums[i]] = i;
    }

    for (int i = 0; i < operationsSize; i++) {
        int oldVal = operations[i][0];
        int newVal = operations[i][1];
        int index = pos[oldVal];
        nums[index] = newVal;
        pos[newVal] = index;
    }

    *returnSize = numsSize;
    return nums;
}