int minMoves(int* nums, int numsSize, int k) {
    int* pos = (int*)malloc(numsSize * sizeof(int));
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            pos[count++] = i;
        }
    }

    if (count < k) {
        free(pos);
        return -1;
    }

    int medianIndex = k / 2;
    int moves = 0;

    for (int i = 0; i < k; i++) {
        moves += pos[i] - pos[medianIndex] - (medianIndex - i);
    }

    free(pos);
    return moves;
}