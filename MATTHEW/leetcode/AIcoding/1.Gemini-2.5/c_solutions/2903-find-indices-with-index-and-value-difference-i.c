int* findIndices(int* nums, int numsSize, int indexDifference, int valueDifference, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsSize; j++) {
            if (abs(i - j) >= indexDifference && abs(nums[i] - nums[j]) >= valueDifference) {
                result[0] = i;
                result[1] = j;
                return result;
            }
        }
    }

    result[0] = -1;
    result[1] = -1;
    return result;
}