int minZeroArray(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize) {
    int* diff = (int*)calloc(numsSize + 2, sizeof(int));
    int total = 0, applied = 0;

    for (int i = 0; i < numsSize; i++) {
        while (total + diff[i] < nums[i]) {
            if (applied == queriesSize) {
                free(diff);
                return -1;
            }
            int l = queries[applied][0];
            int r = queries[applied][1];
            int val = queries[applied][2];
            if (r >= i) {
                diff[l] += val;
                diff[r + 1] -= val;
                if (l <= i) {
                    total += val;
                }
            }
            applied++;
        }
        total += diff[i];
    }

    free(diff);
    return applied;
}