#define MAX_SIZE 100

int* maxScoreIndices(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc((numsSize + 1) * sizeof(int));
    int leftCount[MAX_SIZE] = {0}, rightCount[MAX_SIZE] = {0};
    int maxScore = 0, score = 0;

    for (int i = 0; i < numsSize; i++) {
        rightCount[nums[i]]++;
    }

    for (int i = 0; i <= numsSize; i++) {
        score = leftCount[0] + rightCount[1];
        if (score > maxScore) {
            maxScore = score;
            *returnSize = 0;
        }
        if (score == maxScore) {
            result[(*returnSize)++] = i;
        }
        if (i < numsSize) {
            leftCount[nums[i]]++;
            rightCount[nums[i]]--;
        }
    }

    return result;
}