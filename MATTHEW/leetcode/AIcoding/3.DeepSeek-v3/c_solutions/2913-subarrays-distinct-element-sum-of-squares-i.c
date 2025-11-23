int sumCounts(int* nums, int numsSize) {
    int total = 0;
    for (int i = 0; i < numsSize; i++) {
        int distinct[101] = {0};
        int count = 0;
        for (int j = i; j < numsSize; j++) {
            if (distinct[nums[j]] == 0) {
                count++;
            }
            distinct[nums[j]]++;
            total += count * count;
        }
    }
    return total;
}