/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findIndices(int* nums, int numsSize, int indexDifference, int valueDifference, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;
    result[0] = -1;
    result[1] = -1;

    for (int i = 0; i < numsSize; i++) {
        for (int j = i; j < numsSize; j++) {
            if (abs(i - j) >= indexDifference && abs(nums[i] - nums[j]) >= valueDifference) {
                result[0] = i;
                result[1] = j;
                return result;
            }
        }
    }

    return result;
}