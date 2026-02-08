int sumFourDivisors(int* nums, int numsSize) {
    int total = 0;
    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int divisor_count = 0;
        int divisor_sum = 0;

        for (int d = 1; d * d <= num; d++) {
            if (num % d == 0) {
                divisor_count++;
                divisor_sum += d;

                if (d != num / d) {
                    divisor_count++;
                    divisor_sum += num / d;
                }

                if (divisor_count > 4) break;
            }
        }

        if (divisor_count == 4) {
            total += divisor_sum;
        }
    }
    return total;
}