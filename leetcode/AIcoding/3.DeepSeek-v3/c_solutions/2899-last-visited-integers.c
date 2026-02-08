/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* lastVisitedIntegers(int** words, int wordsSize, int* wordsColSize, int* returnSize) {
    int* nums = (int*)malloc(wordsSize * sizeof(int));
    int* result = (int*)malloc(wordsSize * sizeof(int));
    int numsSize = 0;
    int resultSize = 0;
    int consecutivePrev = 0;

    for (int i = 0; i < wordsSize; i++) {
        if (wordsColSize[i] == 1 && words[i][0] == 'p') {
            consecutivePrev++;
            if (consecutivePrev <= numsSize) {
                result[resultSize++] = nums[numsSize - consecutivePrev];
            } else {
                result[resultSize++] = -1;
            }
        } else {
            consecutivePrev = 0;
            int num = 0;
            for (int j = 0; j < wordsColSize[i]; j++) {
                num = num * 10 + (words[i][j] - '0');
            }
            nums[numsSize++] = num;
        }
    }

    *returnSize = resultSize;
    free(nums);
    return result;
}