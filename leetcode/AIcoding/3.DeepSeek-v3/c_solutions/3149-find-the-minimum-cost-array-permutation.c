int* findPermutation(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* res = (int*)malloc(numsSize * sizeof(int));
    int* used = (int*)calloc(numsSize, sizeof(int));

    res[0] = 0;
    used[0] = 1;

    for (int i = 1; i < numsSize; i++) {
        int best = -1;
        for (int j = 0; j < numsSize; j++) {
            if (!used[j]) {
                if (best == -1 || abs(res[i-1] - j) + abs(j - nums[res[i-1]]) < 
                                  abs(res[i-1] - best) + abs(best - nums[res[i-1]])) {
                    best = j;
                }
            }
        }
        res[i] = best;
        used[best] = 1;
    }

    free(used);
    return res;
}