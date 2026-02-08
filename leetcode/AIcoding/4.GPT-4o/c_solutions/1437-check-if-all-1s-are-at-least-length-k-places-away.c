bool kLengthApart(int* nums, int numsSize, int k) {
    int lastIndex = -1;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            if (lastIndex != -1 && i - lastIndex - 1 < k) {
                return false;
            }
            lastIndex = i;
        }
    }
    return true;
}