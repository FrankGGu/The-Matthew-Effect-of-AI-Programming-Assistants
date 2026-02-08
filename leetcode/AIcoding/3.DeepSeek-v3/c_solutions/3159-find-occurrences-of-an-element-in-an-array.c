/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* occurrencesOfElement(int* nums, int numsSize, int* queries, int queriesSize, int x, int* returnSize) {
    int* indices = (int*)malloc(numsSize * sizeof(int));
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == x) {
            indices[count++] = i;
        }
    }

    *returnSize = queriesSize;
    int* result = (int*)malloc(queriesSize * sizeof(int));

    for (int i = 0; i < queriesSize; i++) {
        if (queries[i] > count) {
            result[i] = -1;
        } else {
            result[i] = indices[queries[i] - 1];
        }
    }

    free(indices);
    return result;
}