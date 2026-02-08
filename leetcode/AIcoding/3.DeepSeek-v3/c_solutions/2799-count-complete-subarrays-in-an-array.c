int countCompleteSubarrays(int* nums, int numsSize) {
    int totalDistinct = 0;
    int freq[2001] = {0};

    for (int i = 0; i < numsSize; i++) {
        if (freq[nums[i]] == 0) {
            totalDistinct++;
        }
        freq[nums[i]]++;
    }

    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int temp[2001] = {0};
        int distinct = 0;
        for (int j = i; j < numsSize; j++) {
            if (temp[nums[j]] == 0) {
                distinct++;
            }
            temp[nums[j]]++;
            if (distinct == totalDistinct) {
                count++;
            }
        }
    }

    return count;
}