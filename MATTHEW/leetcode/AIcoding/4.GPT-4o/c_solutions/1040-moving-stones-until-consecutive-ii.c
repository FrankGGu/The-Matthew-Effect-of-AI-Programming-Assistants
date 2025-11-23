int* numMovesStonesII(int* stones, int stonesSize, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    int maxPos = stonesSize - 1;
    int minMove = 2, maxMove = 0;

    qsort(stones, stonesSize, sizeof(int), cmp);

    if (stones[0] == 1) minMove--;
    if (stones[maxPos] == maxPos + 1) minMove--;

    for (int i = 0; i < stonesSize; i++) {
        while (stones[i] - stones[0] >= stonesSize) {
            stones[0]++;
        }
        maxMove = fmax(maxMove, stones[i] - i);
    }

    maxMove = fmax(maxMove, stones[maxPos] - stones[0] + 1);

    result[0] = minMove;
    result[1] = maxMove;
    *returnSize = 2;

    return result;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}