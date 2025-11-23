int longestConsecutive(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    int maxLength = 0;
    int* hashSet = (int*)calloc(200001, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] >= 0) {
            hashSet[nums[i]] = 1;
        } else {
            hashSet[100000 + nums[i]] = 1;
        }
    }

    for (int i = 0; i < 200001; i++) {
        if (hashSet[i] == 1) {
            int currentLength = 1;
            while (i + 1 < 200001 && hashSet[i + 1] == 1) {
                currentLength++;
                i++;
            }
            if (currentLength > maxLength) {
                maxLength = currentLength;
            }
        }
    }

    free(hashSet);
    return maxLength;
}