typedef struct {
    int *data;
    int size;
} Vector;

int* findDiagonalOrder(int** nums, int numsSize, int* numsColSize, int* returnSize) {
    int maxSize = 0;
    for (int i = 0; i < numsSize; i++) {
        if (numsColSize[i] > maxSize) {
            maxSize = numsColSize[i];
        }
    }

    Vector *diagonals = (Vector *)malloc((numsSize + maxSize) * sizeof(Vector));
    for (int i = 0; i < numsSize + maxSize; i++) {
        diagonals[i].data = (int *)malloc((numsSize + maxSize) * sizeof(int));
        diagonals[i].size = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsColSize[i]; j++) {
            diagonals[i + j].data[diagonals[i + j].size++] = nums[i][j];
        }
    }

    int *result = (int *)malloc(10000 * sizeof(int));
    int idx = 0;

    for (int i = 0; i < numsSize + maxSize; i++) {
        for (int j = diagonals[i].size - 1; j >= 0; j--) {
            result[idx++] = diagonals[i].data[j];
        }
    }

    *returnSize = idx;

    for (int i = 0; i < numsSize + maxSize; i++) {
        free(diagonals[i].data);
    }
    free(diagonals);

    return result;
}