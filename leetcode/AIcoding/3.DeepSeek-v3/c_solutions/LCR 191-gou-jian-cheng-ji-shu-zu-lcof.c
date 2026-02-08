/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* statisticalResult(int* arrayA, int arrayASize, int* returnSize) {
    *returnSize = arrayASize;
    if (arrayASize == 0) return NULL;

    int* result = (int*)malloc(arrayASize * sizeof(int));
    if (result == NULL) return NULL;

    // Calculate product of all elements
    long long totalProduct = 1;
    int zeroCount = 0;
    int zeroIndex = -1;

    for (int i = 0; i < arrayASize; i++) {
        if (arrayA[i] == 0) {
            zeroCount++;
            zeroIndex = i;
        } else {
            totalProduct *= arrayA[i];
        }
    }

    // Handle cases with zeros
    if (zeroCount > 1) {
        for (int i = 0; i < arrayASize; i++) {
            result[i] = 0;
        }
        return result;
    }

    if (zeroCount == 1) {
        for (int i = 0; i < arrayASize; i++) {
            result[i] = (i == zeroIndex) ? totalProduct : 0;
        }
        return result;
    }

    // No zeros case
    for (int i = 0; i < arrayASize; i++) {
        result[i] = totalProduct / arrayA[i];
    }

    return result;
}