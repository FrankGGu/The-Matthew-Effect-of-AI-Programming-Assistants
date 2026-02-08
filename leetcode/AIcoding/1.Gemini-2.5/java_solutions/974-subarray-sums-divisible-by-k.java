class Solution {
    public int subarraysDivByK(int[] nums, int k) {
        int[] remainderCounts = new int[k];
        remainderCounts[0] = 1; // Base case: an empty prefix sum has a remainder of 0

        int count = 0;
        int currentSum = 0;

        for (int num : nums) {
            currentSum += num;

            // Calculate the remainder.
            // In Java, the % operator can return a negative result if the dividend is negative.
            // To ensure a positive remainder in the range [0, k-1], we add k and then take modulo k again.
            int remainder = currentSum % k;
            if (remainder < 0) {
                remainder += k;
            }

            // If we have seen a previous prefix sum with the same remainder,
            // it means the difference between the current prefix sum and that
            // previous prefix sum is divisible by k.
            // Each such previous occurrence contributes one valid subarray ending at the current position.
            count += remainderCounts[remainder];

            // Increment the count for the current remainder
            remainderCounts[remainder]++;
        }

        return count;
    }
}