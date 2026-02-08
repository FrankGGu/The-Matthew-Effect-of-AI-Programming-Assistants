#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int binarySearch(int* arr, int size, int target) {
    int low = 0;
    int high = size - 1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] == target) {
            return 1;
        } else if (arr[mid] < target) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return 0;
}

int* fairCandySwap(int* aliceSizes, int aliceSizesSize, int* bobSizes, int bobSizesSize, int* returnSize) {
    long long sumA = 0;
    for (int i = 0; i < aliceSizesSize; i++) {
        sumA += aliceSizes[i];
    }

    long long sumB = 0;
    for (int i = 0; i < bobSizesSize; i++) {
        sumB += bobSizes[i];
    }

    long long diff = (sumA - sumB) / 2;

    qsort(bobSizes, bobSizesSize, sizeof(int), compare);

    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    for (int i = 0; i < aliceSizesSize; i++) {
        int x = aliceSizes[i];
        int y = x - diff;

        if (binarySearch(bobSizes, bobSizesSize, y)) {
            result[0] = x;
            result[1] = y;
            return result;
        }
    }

    return NULL;
}