/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
long long makeSimilar(int* nums, int numsSize, int* target, int targetSize) {
    int* evenNums = (int*)malloc(numsSize * sizeof(int));
    int* oddNums = (int*)malloc(numsSize * sizeof(int));
    int* evenTarget = (int*)malloc(targetSize * sizeof(int));
    int* oddTarget = (int*)malloc(targetSize * sizeof(int));

    int evenCount = 0, oddCount = 0;
    int evenTargetCount = 0, oddTargetCount = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            evenNums[evenCount++] = nums[i];
        } else {
            oddNums[oddCount++] = nums[i];
        }
    }

    for (int i = 0; i < targetSize; i++) {
        if (target[i] % 2 == 0) {
            evenTarget[evenTargetCount++] = target[i];
        } else {
            oddTarget[oddTargetCount++] = target[i];
        }
    }

    int cmp(const void* a, const void* b) {
        return *(int*)a - *(int*)b;
    }

    qsort(evenNums, evenCount, sizeof(int), cmp);
    qsort(oddNums, oddCount, sizeof(int), cmp);
    qsort(evenTarget, evenTargetCount, sizeof(int), cmp);
    qsort(oddTarget, oddTargetCount, sizeof(int), cmp);

    long long operations = 0;

    for (int i = 0; i < evenCount; i++) {
        if (evenNums[i] < evenTarget[i]) {
            operations += (evenTarget[i] - evenNums[i]) / 2;
        }
    }

    for (int i = 0; i < oddCount; i++) {
        if (oddNums[i] < oddTarget[i]) {
            operations += (oddTarget[i] - oddNums[i]) / 2;
        }
    }

    free(evenNums);
    free(oddNums);
    free(evenTarget);
    free(oddTarget);

    return operations;
}