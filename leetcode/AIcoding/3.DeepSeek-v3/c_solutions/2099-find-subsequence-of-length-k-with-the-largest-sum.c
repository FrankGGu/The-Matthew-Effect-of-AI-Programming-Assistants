/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* maxSubsequence(int* nums, int numsSize, int k, int* returnSize) {
    int* result = (int*)malloc(k * sizeof(int));
    *returnSize = k;

    // Create an array of indices
    int* indices = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        indices[i] = i;
    }

    // Sort indices based on the corresponding values in nums (descending order)
    for (int i = 0; i < numsSize - 1; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (nums[indices[i]] < nums[indices[j]]) {
                int temp = indices[i];
                indices[i] = indices[j];
                indices[j] = temp;
            }
        }
    }

    // Take the first k indices with largest values
    int* topIndices = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        topIndices[i] = indices[i];
    }

    // Sort these indices to maintain original order
    for (int i = 0; i < k - 1; i++) {
        for (int j = i + 1; j < k; j++) {
            if (topIndices[i] > topIndices[j]) {
                int temp = topIndices[i];
                topIndices[i] = topIndices[j];
                topIndices[j] = temp;
            }
        }
    }

    // Fill the result array in the original order
    for (int i = 0; i < k; i++) {
        result[i] = nums[topIndices[i]];
    }

    free(indices);
    free(topIndices);

    return result;
}