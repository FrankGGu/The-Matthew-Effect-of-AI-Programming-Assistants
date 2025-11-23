/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** permuteUnique(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int total = 1;
    for (int i = 1; i <= numsSize; i++) total *= i;

    int** result = (int**)malloc(total * sizeof(int*));
    *returnColumnSizes = (int*)malloc(total * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < total; i++) {
        (*returnColumnSizes)[i] = numsSize;
    }

    qsort(nums, numsSize, sizeof(int), cmpfunc);

    do {
        result[*returnSize] = (int*)malloc(numsSize * sizeof(int));
        for (int i = 0; i < numsSize; i++) {
            result[*returnSize][i] = nums[i];
        }
        (*returnSize)++;
    } while (nextPermutation(nums, numsSize));

    return result;
}

int cmpfunc(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int nextPermutation(int* nums, int numsSize) {
    int i = numsSize - 2;
    while (i >= 0 && nums[i] >= nums[i + 1]) {
        i--;
    }
    if (i < 0) {
        return 0;
    }

    int j = numsSize - 1;
    while (j >= 0 && nums[j] <= nums[i]) {
        j--;
    }

    swap(nums, i, j);
    reverse(nums, i + 1, numsSize - 1);
    return 1;
}

void swap(int* nums, int i, int j) {
    int temp = nums[i];
    nums[i] = nums[j];
    nums[j] = temp;
}

void reverse(int* nums, int start, int end) {
    while (start < end) {
        swap(nums, start, end);
        start++;
        end--;
    }
}