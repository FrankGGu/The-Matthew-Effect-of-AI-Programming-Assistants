int maxProduct(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    int maxProd = nums[0];
    int minProd = nums[0];
    int result = nums[0];

    for (int i = 1; i < numsSize; i++) {
        int temp = maxProd;
        maxProd = fmax(nums[i], fmax(maxProd * nums[i], minProd * nums[i]));
        minProd = fmin(nums[i], fmin(temp * nums[i], minProd * nums[i]));
        result = fmax(result, maxProd);
    }

    return result;
}