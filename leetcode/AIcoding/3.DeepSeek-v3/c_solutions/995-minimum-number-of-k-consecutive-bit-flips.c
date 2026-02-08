int minKBitFlips(int* nums, int numsSize, int k) {
    int* flip = (int*)calloc(numsSize + 1, sizeof(int));
    int current = 0;
    int result = 0;

    for (int i = 0; i < numsSize; i++) {
        current ^= flip[i];
        if ((nums[i] ^ current) == 0) {
            if (i + k > numsSize) {
                free(flip);
                return -1;
            }
            result++;
            current ^= 1;
            if (i + k < numsSize) {
                flip[i + k] ^= 1;
            }
        }
    }

    free(flip);
    return result;
}