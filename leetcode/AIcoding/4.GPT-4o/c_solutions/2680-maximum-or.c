int maximumOr(int* nums, int numsSize, int k) {
    int maxOr = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsSize; j++) {
            if (i != j) {
                int orValue = nums[i];
                for (int l = 0; l < k; l++) {
                    orValue |= (nums[j] << l);
                }
                if (orValue > maxOr) {
                    maxOr = orValue;
                }
            }
        }
    }
    return maxOr;
}