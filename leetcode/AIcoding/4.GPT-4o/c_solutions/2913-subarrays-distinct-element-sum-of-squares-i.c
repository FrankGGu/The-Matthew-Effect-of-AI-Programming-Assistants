int sumOfSquares(int* nums, int numsSize) {
    int count = 0;
    int maxUnique = 0;

    for (int i = 0; i < numsSize; i++) {
        int freq[1001] = {0};
        int uniqueCount = 0;

        for (int j = i; j < numsSize; j++) {
            if (freq[nums[j]] == 0) {
                uniqueCount++;
            }
            freq[nums[j]]++;
            count += uniqueCount * uniqueCount;
        }
    }

    return count;
}