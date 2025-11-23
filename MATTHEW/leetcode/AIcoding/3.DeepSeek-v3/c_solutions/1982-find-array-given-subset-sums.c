#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int* recoverArray(int n, int* sums, int sumsSize, int* returnSize) {
    qsort(sums, sumsSize, sizeof(int), cmp);
    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;
    int idx = 0;

    int* current = (int*)malloc(sumsSize * sizeof(int));
    memcpy(current, sums, sumsSize * sizeof(int));
    int currentSize = sumsSize;

    for (int i = 0; i < n; i++) {
        int diff = current[1] - current[0];
        int hasZero = 0;
        int* left = (int*)malloc(currentSize * sizeof(int));
        int* right = (int*)malloc(currentSize * sizeof(int));
        int leftIdx = 0, rightIdx = 0;

        int* used = (int*)calloc(currentSize, sizeof(int));
        for (int j = 0; j < currentSize; j++) {
            if (used[j]) continue;
            if (current[j] == 0) hasZero = 1;
            used[j] = 1;
            left[leftIdx++] = current[j];
            int target = current[j] + diff;
            int k = j + 1;
            while (k < currentSize && (used[k] || current[k] != target)) k++;
            if (k < currentSize) {
                used[k] = 1;
                right[rightIdx++] = current[k];
            }
        }

        if (hasZero) {
            result[idx++] = diff;
            memcpy(current, left, leftIdx * sizeof(int));
            currentSize = leftIdx;
        } else {
            result[idx++] = -diff;
            memcpy(current, right, rightIdx * sizeof(int));
            currentSize = rightIdx;
        }

        free(left);
        free(right);
        free(used);
    }

    free(current);
    return result;
}