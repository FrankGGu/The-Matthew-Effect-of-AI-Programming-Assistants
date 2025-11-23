/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findLonely(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = 0;

    if (numsSize == 1) {
        result[0] = nums[0];
        *returnSize = 1;
        return result;
    }

    qsort(nums, numsSize, sizeof(int), cmpfunc);

    for (int i = 0; i < numsSize; i++) {
        if (i == 0) {
            if (nums[i+1] != nums[i] && nums[i+1] != nums[i] + 1) {
                result[(*returnSize)++] = nums[i];
            }
        } else if (i == numsSize - 1) {
            if (nums[i-1] != nums[i] && nums[i-1] != nums[i] - 1) {
                result[(*returnSize)++] = nums[i];
            }
        } else {
            if (nums[i-1] != nums[i] && nums[i-1] != nums[i] - 1 &&
                nums[i+1] != nums[i] && nums[i+1] != nums[i] + 1) {
                result[(*returnSize)++] = nums[i];
            }
        }
    }

    return result;
}

int cmpfunc(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}