int* smallestSubarrays(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;

    for (int i = 0; i < numsSize; i++) {
        int maxOR = 0, j = i;
        while (j < numsSize) {
            maxOR |= nums[j];
            if (maxOR == nums[i]) {
                break;
            }
            j++;
        }
        result[i] = j - i + 1;
    }

    return result;
}