/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* fairCandySwap(int* aliceSizes, int aliceSizesSize, int* bobSizes, int bobSizesSize, int* returnSize) {
    int aliceSum = 0, bobSum = 0;
    for (int i = 0; i < aliceSizesSize; i++) {
        aliceSum += aliceSizes[i];
    }
    for (int i = 0; i < bobSizesSize; i++) {
        bobSum += bobSizes[i];
    }

    int diff = (aliceSum - bobSum) / 2;

    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    int bobPresent[100001] = {0};
    for (int i = 0; i < bobSizesSize; i++) {
        bobPresent[bobSizes[i]] = 1;
    }

    for (int i = 0; i < aliceSizesSize; i++) {
        int target = aliceSizes[i] - diff;
        if (target >= 1 && target <= 100000 && bobPresent[target]) {
            result[0] = aliceSizes[i];
            result[1] = target;
            break;
        }
    }

    return result;
}