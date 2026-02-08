/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char** summaryRanges(int* nums, int numsSize, int* returnSize) {
    if (numsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    char** result = (char**)malloc(numsSize * sizeof(char*));
    int count = 0;
    int start = 0;

    for (int i = 0; i < numsSize; i++) {
        if (i == numsSize - 1 || nums[i] + 1 != nums[i + 1]) {
            result[count] = (char*)malloc(25 * sizeof(char));
            if (start == i) {
                sprintf(result[count], "%d", nums[start]);
            } else {
                sprintf(result[count], "%d->%d", nums[start], nums[i]);
            }
            count++;
            start = i + 1;
        }
    }

    *returnSize = count;
    return result;
}