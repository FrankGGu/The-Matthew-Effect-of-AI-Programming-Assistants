int countDivisibleConcatenations(int* nums, int numsSize, int k) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsSize; j++) {
            if (i == j) continue;

            long long combined = nums[i];
            int temp = nums[j];
            long long multiplier = 1;
            while (temp > 0) {
                multiplier *= 10;
                temp /= 10;
            }
            combined = combined * multiplier + nums[j];

            if (combined % k == 0) {
                count++;
            }
        }
    }
    return count;
}