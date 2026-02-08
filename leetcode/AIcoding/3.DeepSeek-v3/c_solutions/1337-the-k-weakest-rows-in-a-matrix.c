/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* kWeakestRows(int** mat, int matSize, int* matColSize, int k, int* returnSize) {
    int* result = (int*)malloc(k * sizeof(int));
    int* soldiers = (int*)malloc(matSize * sizeof(int));

    for (int i = 0; i < matSize; i++) {
        int count = 0;
        for (int j = 0; j < matColSize[i]; j++) {
            if (mat[i][j] == 1) {
                count++;
            } else {
                break;
            }
        }
        soldiers[i] = count;
    }

    int* indices = (int*)malloc(matSize * sizeof(int));
    for (int i = 0; i < matSize; i++) {
        indices[i] = i;
    }

    for (int i = 0; i < matSize - 1; i++) {
        for (int j = 0; j < matSize - i - 1; j++) {
            if (soldiers[j] > soldiers[j + 1] || 
                (soldiers[j] == soldiers[j + 1] && indices[j] > indices[j + 1])) {
                int tempSoldier = soldiers[j];
                soldiers[j] = soldiers[j + 1];
                soldiers[j + 1] = tempSoldier;

                int tempIndex = indices[j];
                indices[j] = indices[j + 1];
                indices[j + 1] = tempIndex;
            }
        }
    }

    for (int i = 0; i < k; i++) {
        result[i] = indices[i];
    }

    free(soldiers);
    free(indices);

    *returnSize = k;
    return result;
}