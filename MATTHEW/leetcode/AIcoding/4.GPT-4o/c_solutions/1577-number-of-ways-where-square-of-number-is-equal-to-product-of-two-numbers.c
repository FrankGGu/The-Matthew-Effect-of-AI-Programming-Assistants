int numOfWays(int* nums, int numsSize) {
    long long count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            long long product = (long long)nums[i] * nums[j];
            long long square = product * product;
            for (int k = 0; k < numsSize; k++) {
                if (nums[k] != nums[i] && nums[k] != nums[j] && square % nums[k] == 0) {
                    long long target = square / nums[k];
                    if (target != nums[i] && target != nums[j] && target != nums[k]) {
                        count++;
                    }
                }
            }
        }
    }
    return count / 6;
}