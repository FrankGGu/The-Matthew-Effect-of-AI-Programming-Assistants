int countTriplets(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsSize; j++) {
            for (int k = 0; k < numsSize; k++) {
                if ((nums[i] ^ nums[j] ^ nums[k]) == 0) {
                    count++;
                }
            }
        }
    }
    return count;
}