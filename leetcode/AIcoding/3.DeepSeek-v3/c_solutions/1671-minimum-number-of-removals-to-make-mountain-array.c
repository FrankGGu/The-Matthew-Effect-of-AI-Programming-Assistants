int minimumMountainRemovals(int* nums, int numsSize) {
    int* lis = (int*)malloc(numsSize * sizeof(int));
    int* lds = (int*)malloc(numsSize * sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        lis[i] = 1;
        for (int j = 0; j < i; j++) {
            if (nums[i] > nums[j]) {
                lis[i] = fmax(lis[i], lis[j] + 1);
            }
        }
    }

    for (int i = numsSize - 1; i >= 0; i--) {
        lds[i] = 1;
        for (int j = numsSize - 1; j > i; j--) {
            if (nums[i] > nums[j]) {
                lds[i] = fmax(lds[i], lds[j] + 1);
            }
        }
    }

    int maxMountain = 0;
    for (int i = 0; i < numsSize; i++) {
        if (lis[i] > 1 && lds[i] > 1) {
            maxMountain = fmax(maxMountain, lis[i] + lds[i] - 1);
        }
    }

    free(lis);
    free(lds);

    return numsSize - maxMountain;
}