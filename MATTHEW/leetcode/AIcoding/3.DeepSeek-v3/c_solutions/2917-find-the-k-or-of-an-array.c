int findKOr(int* nums, int numsSize, int k) {
    int result = 0;
    for (int i = 0; i < 31; i++) {
        int count = 0;
        for (int j = 0; j < numsSize; j++) {
            if (nums[j] & (1 << i)) {
                count++;
            }
        }
        if (count >= k) {
            result |= (1 << i);
        }
    }
    return result;
}