class Solution {
    public int minOperations(int[] nums) {
        int totalIncrements = 0;
        int maxVal = 0;

        for (int num : nums) {
            // Each '1' bit in the binary representation of a number
            // corresponds to an 'increment' operation.
            totalIncrements += Integer.bitCount(num);
            // Keep track of the maximum value to determine the number of 'double' operations.
            maxVal = Math.max(maxVal, num);
        }

        int numDoubles = 0;
        if (maxVal > 0) {
            // The number of 'double' operations is determined by the largest number.
            // It's equivalent to floor(log base 2 of maxVal), which is the position
            // of the most significant bit (0-indexed) or (number of bits - 1).
            // Integer.numberOfLeadingZeros(maxVal) returns the number of zero bits
            // preceding the highest-order one-bit.
            // For a 32-bit integer, 31 - numberOfLeadingZeros(maxVal) gives the
            // 0-indexed position of the most significant bit.
            numDoubles = 31 - Integer.numberOfLeadingZeros(maxVal);
        }

        return totalIncrements + numDoubles;
    }
}