int findNumberOfLIS(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    int* lengths = (int*)malloc(numsSize * sizeof(int));
    int* counts = (int*)malloc(numsSize * sizeof(int));
    int maxLength = 1;

    for (int i = 0; i < numsSize; i++) {
        lengths[i] = 1;
        counts[i] = 1;
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < i; j++) {
            if (nums[i] > nums[j]) {
                if (lengths[j] + 1 > lengths[i]) {
                    lengths[i] = lengths[j] + 1;
                    counts[i] = counts[j];
                } else if (lengths[j] + 1 == lengths[i]) {
                    counts[i] += counts[j];
                }
            }
        }
        maxLength = fmax(maxLength, lengths[i]);
    }

    int result = 0;
    for (int i = 0; i < numsSize; i++) {
        if (lengths[i] == maxLength) {
            result += counts[i];
        }
    }

    free(lengths);
    free(counts);
    return result;
}