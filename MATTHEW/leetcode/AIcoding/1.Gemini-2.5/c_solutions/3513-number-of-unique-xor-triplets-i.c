int uniqueXORTriplets(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize - 2; i++) {
        for (int j = i + 1; j < numsSize - 1; j++) {
            for (int k = j + 1; k < numsSize; k++) {
                if ((nums[i] ^ nums[j] ^ nums[k]) == 0) {
                    count++;
                }
            }
        }
    }
    return count;
}