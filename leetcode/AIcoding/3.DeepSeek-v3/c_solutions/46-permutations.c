/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** permute(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int total = 1;
    for (int i = 1; i <= numsSize; i++) {
        total *= i;
    }

    *returnSize = total;
    *returnColumnSizes = (int*)malloc(total * sizeof(int));
    int** result = (int**)malloc(total * sizeof(int*));

    for (int i = 0; i < total; i++) {
        (*returnColumnSizes)[i] = numsSize;
        result[i] = (int*)malloc(numsSize * sizeof(int));
    }

    int* temp = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        temp[i] = nums[i];
    }

    int count = 0;

    void swap(int* a, int* b) {
        int temp = *a;
        *a = *b;
        *b = temp;
    }

    void generate(int start) {
        if (start == numsSize) {
            for (int i = 0; i < numsSize; i++) {
                result[count][i] = temp[i];
            }
            count++;
            return;
        }

        for (int i = start; i < numsSize; i++) {
            swap(&temp[start], &temp[i]);
            generate(start + 1);
            swap(&temp[start], &temp[i]);
        }
    }

    generate(0);
    free(temp);
    return result;
}