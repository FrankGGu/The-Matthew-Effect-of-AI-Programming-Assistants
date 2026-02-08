long long maximumTripletValue(int* nums, int numsSize) {
    long long max_val = 0;

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            for (int k = j + 1; k < numsSize; k++) {
                long long current_product = (long long)(nums[i] - nums[j]) * nums[k];
                if (current_product > max_val) {
                    max_val = current_product;
                }
            }
        }
    }

    return max_val;
}