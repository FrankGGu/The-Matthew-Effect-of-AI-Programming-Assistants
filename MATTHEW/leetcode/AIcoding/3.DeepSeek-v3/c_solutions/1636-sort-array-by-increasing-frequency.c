/**
 * Note: The returned array must be malloced, assume caller calls free().
 */

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int compareFreq(const void* a, const void* b) {
    int* pa = (int*)a;
    int* pb = (int*)b;

    if (pa[1] != pb[1]) {
        return pa[1] - pb[1];
    }
    return pb[0] - pa[0];
}

int* frequencySort(int* nums, int numsSize, int* returnSize) {
    int freq[201] = {0};
    int offset = 100;

    for (int i = 0; i < numsSize; i++) {
        freq[nums[i] + offset]++;
    }

    int** pairs = (int**)malloc(numsSize * sizeof(int*));
    for (int i = 0; i < numsSize; i++) {
        pairs[i] = (int*)malloc(2 * sizeof(int));
        pairs[i][0] = nums[i];
        pairs[i][1] = freq[nums[i] + offset];
    }

    qsort(pairs, numsSize, sizeof(int*), compareFreq);

    int* result = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        result[i] = pairs[i][0];
        free(pairs[i]);
    }
    free(pairs);

    *returnSize = numsSize;
    return result;
}