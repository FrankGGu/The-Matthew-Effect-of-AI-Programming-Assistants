int countTriplets(int* nums, int numsSize) {
    int maxVal = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxVal) maxVal = nums[i];
    }

    int* freq = (int*)calloc(maxVal + 1, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsSize; j++) {
            freq[nums[i] & nums[j]]++;
        }
    }

    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int k = 0; k <= maxVal; k++) {
            if ((nums[i] & k) == 0) {
                count += freq[k];
            }
        }
    }

    free(freq);
    return count;
}