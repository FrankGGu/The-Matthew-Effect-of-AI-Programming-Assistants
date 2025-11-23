bool kLengthApart(int* nums, int numsSize, int k) {
    int lastOneIndex = -k - 1; // Initialize to a value that ensures the first '1' is valid

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            if (i - lastOneIndex <= k) {
                return false;
            }
            lastOneIndex = i;
        }
    }

    return true;
}