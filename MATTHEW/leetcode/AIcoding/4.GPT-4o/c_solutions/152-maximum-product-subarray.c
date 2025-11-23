int maxProduct(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    int maxProd = nums[0], minProd = nums[0], result = nums[0];

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < 0) {
            int temp = maxProd;
            maxProd = minProd;
            minProd = temp;
        }
        maxProd = fmax(nums[i], maxProd * nums[i]);
        minProd = fmin(nums[i], minProd * nums[i]);
        result = fmax(result, maxProd);
    }

    return result;
}