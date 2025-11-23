int longestConsecutive(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    int maxLength = 0;
    int *hashMap = (int*)calloc(200001, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < 0) continue;
        hashMap[nums[i]] = 1;
    }

    for (int i = 0; i < 200001; i++) {
        if (hashMap[i]) {
            int length = 0;
            while (hashMap[i]) {
                length++;
                i++;
            }
            if (length > maxLength) {
                maxLength = length;
            }
        }
    }

    free(hashMap);
    return maxLength;
}