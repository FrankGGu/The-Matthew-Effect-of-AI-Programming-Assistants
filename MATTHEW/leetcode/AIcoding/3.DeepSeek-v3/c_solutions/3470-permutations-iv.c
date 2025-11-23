/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the returned arrays are returned as *returnColumnSizes.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** permute(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = 1;
    for (int i = 1; i <= numsSize; i++) {
        *returnSize *= i;
    }

    int** result = (int**)malloc(*returnSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(*returnSize * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        (*returnColumnSizes)[i] = numsSize;
        result[i] = (int*)malloc(numsSize * sizeof(int));
        memcpy(result[i], nums, numsSize * sizeof(int));
    }

    int* indices = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        indices[i] = i;
    }

    int count = 0;

    do {
        for (int i = 0; i < numsSize; i++) {
            result[count][i] = nums[indices[i]];
        }
        count++;

        int i = numsSize - 2;
        while (i >= 0 && indices[i] >= indices[i + 1]) {
            i--;
        }

        if (i < 0) {
            break;
        }

        int j = numsSize - 1;
        while (indices[j] <= indices[i]) {
            j--;
        }

        int temp = indices[i];
        indices[i] = indices[j];
        indices[j] = temp;

        int left = i + 1;
        int right = numsSize - 1;
        while (left < right) {
            temp = indices[left];
            indices[left] = indices[right];
            indices[right] = temp;
            left++;
            right--;
        }
    } while (count < *returnSize);

    free(indices);
    return result;
}