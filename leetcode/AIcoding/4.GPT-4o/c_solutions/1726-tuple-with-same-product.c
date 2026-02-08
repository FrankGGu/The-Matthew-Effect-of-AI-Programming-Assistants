int tupleSameProduct(int* nums, int numsSize) {
    int count = 0;
    int productCount[1000001] = {0};

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            int product = nums[i] * nums[j];
            productCount[product]++;
        }
    }

    for (int k = 0; k < 1000001; k++) {
        if (productCount[k] > 1) {
            count += productCount[k] * (productCount[k] - 1) / 2 * 8;
        }
    }

    return count;
}