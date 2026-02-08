int minMoves(int* nums, int numsSize, int k) {
    int* ones = (int*)malloc(numsSize * sizeof(int));
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            ones[count++] = i;
        }
    }

    if (count < k) return -1;

    int mid = k / 2;
    int res = 0;

    for (int i = 0; i < k; i++) {
        res += ones[i] - ones[mid] - (mid - i); 
    }

    int minMoves = res;

    for (int i = k; i < count; i++) {
        res += (ones[i] - ones[i - k]) - (ones[mid + i - k] - ones[mid]);
        minMoves = fmin(minMoves, res);
    }

    free(ones);
    return minMoves;
}