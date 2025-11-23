int* findTheDistinctDifferenceArray(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int* leftCount = (int*)calloc(100001, sizeof(int));
    int* rightCount = (int*)calloc(100001, sizeof(int));
    int leftDistinct = 0, rightDistinct = 0;

    for (int i = 0; i < numsSize; i++) {
        rightCount[nums[i]]++;
    }

    for (int i = 0; i < numsSize; i++) {
        if (leftCount[nums[i]] == 0) {
            leftDistinct++;
        }
        leftCount[nums[i]]++;

        rightCount[nums[i]]--;
        if (rightCount[nums[i]] == 0) {
            rightDistinct--;
        } else if (rightCount[nums[i]] == 1) {
            rightDistinct++;
        }

        result[i] = leftDistinct - rightDistinct;
    }

    free(rightCount);
    free(leftCount);
    *returnSize = numsSize;
    return result;
}