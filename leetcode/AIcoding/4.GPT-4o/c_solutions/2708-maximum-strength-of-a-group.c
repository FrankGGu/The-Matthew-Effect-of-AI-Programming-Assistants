int maxStrength(int* nums, int numsSize) {
    int max_product = 1, negative_count = 0, zero_count = 0;
    int max_negative = INT_MIN;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            max_product *= nums[i];
        } else if (nums[i] < 0) {
            negative_count++;
            max_negative = max_negative > nums[i] ? max_negative : nums[i];
            max_product *= nums[i];
        } else {
            zero_count++;
        }
    }

    if (negative_count % 2 == 1) {
        if (negative_count == 1 && zero_count > 0) {
            return 0;
        }
        max_product /= max_negative;
    }

    return max_product;
}