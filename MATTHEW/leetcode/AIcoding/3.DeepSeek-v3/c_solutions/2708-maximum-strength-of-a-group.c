long long maxStrength(int* nums, int numsSize) {
    if (numsSize == 1) return nums[0];

    long long max_neg = -10;
    long long min_neg = 0;
    int neg_count = 0;
    int zero_count = 0;
    long long product = 1;
    int has_pos = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            product *= nums[i];
            has_pos = 1;
        } else if (nums[i] < 0) {
            neg_count++;
            if (max_neg == -10 || nums[i] > max_neg) {
                max_neg = nums[i];
            }
            if (min_neg == 0 || nums[i] < min_neg) {
                min_neg = nums[i];
            }
            product *= nums[i];
        } else {
            zero_count++;
        }
    }

    if (zero_count == numsSize) return 0;

    if (neg_count == 1 && zero_count > 0 && !has_pos) {
        return 0;
    }

    if (neg_count % 2 == 1) {
        if (neg_count == 1 && numsSize == 1) {
            return product;
        }
        if (max_neg == -10) {
            return product;
        }
        product /= max_neg;
    }

    if (product == 1 && zero_count > 0 && !has_pos && neg_count == 0) {
        return 0;
    }

    return product;
}