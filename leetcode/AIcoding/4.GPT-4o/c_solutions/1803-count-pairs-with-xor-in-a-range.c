int countPairs(int* nums, int numsSize, int low, int high) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            int xorValue = nums[i] ^ nums[j];
            if (xorValue >= low && xorValue <= high) {
                count++;
            }
        }
    }
    return count;
}