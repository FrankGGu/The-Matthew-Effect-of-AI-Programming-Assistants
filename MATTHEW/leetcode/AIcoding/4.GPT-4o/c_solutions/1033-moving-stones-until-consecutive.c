typedef struct {
    int min;
    int max;
} Result;

int* numMovesStones(int a, int b, int c, int* returnSize) {
    int *result = (int *)malloc(3 * sizeof(int));
    int stones[3] = {a, b, c};
    qsort(stones, 3, sizeof(int), cmp);

    int minStone = stones[0];
    int midStone = stones[1];
    int maxStone = stones[2];

    int maxMoves = maxStone - minStone - 2;
    int minMoves = 0;

    if (maxStone - midStone == 1 && midStone - minStone == 1) {
        minMoves = 0;
    } else if (maxStone - midStone <= 2 || midStone - minStone <= 2) {
        minMoves = 1;
    } else {
        minMoves = 2;
    }

    result[0] = minMoves;
    result[1] = maxMoves;
    result[2] = 0;

    *returnSize = 3;
    return result;
}

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}