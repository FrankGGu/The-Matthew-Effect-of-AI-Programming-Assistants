int arithmeticTriplets(int* nums, int numsSize, int diff) {
    int count = 0;
    int hash[201] = {0};

    for (int i = 0; i < numsSize; i++) {
        hash[nums[i]] = 1;
    }

    for (int i = 0; i < numsSize; i++) {
        if (hash[nums[i] - diff] && hash[nums[i] - 2 * diff]) {
            count++;
        }
    }

    return count;
}