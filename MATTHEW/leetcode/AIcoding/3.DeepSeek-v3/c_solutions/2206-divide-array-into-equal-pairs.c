int divideArray(int* nums, int numsSize) {
    int freq[501] = {0};
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }
    for (int i = 1; i <= 500; i++) {
        if (freq[i] % 2 != 0) {
            return 0;
        }
    }
    return 1;
}