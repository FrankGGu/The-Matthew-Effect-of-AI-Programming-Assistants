int maxNumOfMarkedIndices(int* nums, int numsSize) {
    int count = 0;
    int* marked = (int*)calloc(numsSize, sizeof(int));
    qsort(nums, numsSize, sizeof(int), cmp);

    for (int i = 0; i < numsSize / 2; i++) {
        if (!marked[i]) {
            for (int j = numsSize / 2; j < numsSize; j++) {
                if (!marked[j] && nums[j] >= 2 * nums[i]) {
                    marked[i] = 1;
                    marked[j] = 1;
                    count += 2;
                    break;
                }
            }
        }
    }

    free(marked);
    return count;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}