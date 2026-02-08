int minimumMountainRemovals(int* nums, int numsSize) {
    int* lis = (int*)malloc(sizeof(int) * numsSize);
    int* lds = (int*)malloc(sizeof(int) * numsSize);

    for (int i = 0; i < numsSize; i++) {
        lis[i] = 1;
        lds[i] = 1;
    }

    for (int i = 1; i < numsSize; i++) {
        for (int j = 0; j < i; j++) {
            if (nums[i] > nums[j]) {
                lis[i] = fmax(lis[i], lis[j] + 1);
            }
        }
    }

    for (int i = numsSize - 2; i >= 0; i--) {
        for (int j = numsSize - 1; j > i; j--) {
            if (nums[i] > nums[j]) {
                lds[i] = fmax(lds[i], lds[j] + 1);
            }
        }
    }

    int maxMountainLength = 0;
    for (int i = 1; i < numsSize - 1; i++) {
        if (lis[i] > 1 && lds[i] > 1) {
            maxMountainLength = fmax(maxMountainLength, lis[i] + lds[i] - 1);
        }
    }

    free(lis);
    free(lds);

    return numsSize - maxMountainLength;
}