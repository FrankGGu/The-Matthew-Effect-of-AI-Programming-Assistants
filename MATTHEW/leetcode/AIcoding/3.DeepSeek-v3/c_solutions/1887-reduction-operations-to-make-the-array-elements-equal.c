int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int reductionOperations(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);

    int operations = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] != nums[i - 1]) {
            operations += i;
        }
    }

    return operations;
}