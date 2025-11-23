class Solution {
    public int sumOfFlooredPairs(int[] nums) {
        int MOD = 1_000_000_007;

        int maxVal = 0;
        for (int num : nums) {
            maxVal = Math.max(maxVal, num);
        }

        int[] freq = new int[maxVal + 1];
        for (int num : nums) {
            freq[num]++;
        }

        int[] prefixCount = new int[maxVal + 1];
        // prefixCount[k] stores the total count of numbers in 'nums' that are <= k.
        // Since nums[i] >= 1, freq[0] will be 0, so prefixCount[0] will be 0.
        for (int i = 1; i <= maxVal; i++) {
            prefixCount[i] = prefixCount[i - 1] + freq[i];
        }

        long totalSum = 0;

        // Iterate through each possible value 'y' that can be nums[j]
        for (int y = 1; y <= maxVal; y++) {
            if (freq[y] == 0) {
                continue; // If y does not exist in nums, it cannot be nums[j]
            }

            long currentSumForThisY = 0;
            // Iterate through multiples of y: p*y, (p+1)*y, etc.
            // 'p' represents the value of floor(x / y)
            for (int p = 1; ; p++) {
                int lowerBoundX = p * y;
                if (lowerBoundX > maxVal) {
                    break; // No more x values can have floor(x/y) = p
                }

                int upperBoundX = (p + 1) * y - 1;
                upperBoundX = Math.min(upperBoundX, maxVal);

                // Count of numbers 'x' in 'nums' such that lowerBoundX <= x <= upperBoundX.
                // For all such 'x', floor(x / y) will be 'p'.
                long countXInRange = prefixCount[upperBoundX] - prefixCount[lowerBoundX - 1];

                currentSumForThisY = (currentSumForThisY + (long)p * countXInRange) % MOD;
            }

            // Multiply by freq[y] because 'y' appears freq[y] times as a divisor (nums[j])
            totalSum = (totalSum + currentSumForThisY * freq[y]) % MOD;
        }

        return (int) totalSum;
    }
}