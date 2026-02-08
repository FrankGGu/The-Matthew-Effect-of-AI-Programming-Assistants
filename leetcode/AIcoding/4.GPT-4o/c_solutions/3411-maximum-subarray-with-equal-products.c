int maxEqualProducts(int* nums, int numsSize) {
    int max_length = 0;
    for (int i = 0; i < numsSize; i++) {
        int product = 1;
        for (int j = i; j < numsSize; j++) {
            product *= nums[j];
            if (product == 0) break;
            int length = j - i + 1;
            if (length > max_length) {
                int isEqual = 1;
                for (int k = i; k < j; k++) {
                    if (nums[k] * nums[j] != product) {
                        isEqual = 0;
                        break;
                    }
                }
                if (isEqual) {
                    max_length = length;
                }
            }
        }
    }
    return max_length;
}