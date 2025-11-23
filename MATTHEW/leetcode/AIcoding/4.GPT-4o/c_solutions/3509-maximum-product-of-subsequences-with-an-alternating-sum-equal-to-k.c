int maxProduct(int* nums, int numsSize, int k) {
    int max_product = 0;
    for (int mask = 1; mask < (1 << numsSize); mask++) {
        int sum = 0;
        int product = 1;
        int count = 0;
        for (int i = 0; i < numsSize; i++) {
            if (mask & (1 << i)) {
                sum += nums[i] * (count % 2 == 0 ? 1 : -1);
                product *= nums[i];
                count++;
            }
        }
        if (sum == k) {
            max_product = fmax(max_product, product);
        }
    }
    return max_product;
}