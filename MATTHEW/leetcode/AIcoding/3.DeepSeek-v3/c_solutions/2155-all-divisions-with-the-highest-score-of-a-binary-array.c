/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* maxScoreIndices(int* nums, int numsSize, int* returnSize) {
    int totalOnes = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) totalOnes++;
    }

    int maxScore = totalOnes;
    int leftZeros = 0;
    int rightOnes = totalOnes;

    int* temp = (int*)malloc(sizeof(int) * (numsSize + 1));
    int count = 0;
    temp[count++] = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) leftZeros++;
        else rightOnes--;

        int score = leftZeros + rightOnes;
        if (score > maxScore) {
            maxScore = score;
            count = 0;
            temp[count++] = i + 1;
        } else if (score == maxScore) {
            temp[count++] = i + 1;
        }
    }

    *returnSize = count;
    int* result = (int*)malloc(sizeof(int) * count);
    for (int i = 0; i < count; i++) {
        result[i] = temp[i];
    }
    free(temp);
    return result;
}