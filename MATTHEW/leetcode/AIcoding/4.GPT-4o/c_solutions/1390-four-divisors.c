int sumFourDivisors(int* nums, int numsSize) {
    int totalSum = 0;

    for (int i = 0; i < numsSize; i++) {
        int count = 0, sum = 0;
        for (int j = 1; j * j <= nums[i]; j++) {
            if (nums[i] % j == 0) {
                count++;
                sum += j;
                if (j != nums[i] / j) {
                    count++;
                    sum += nums[i] / j;
                }
            }
            if (count > 4) break;
        }
        if (count == 4) totalSum += sum;
    }

    return totalSum;
}