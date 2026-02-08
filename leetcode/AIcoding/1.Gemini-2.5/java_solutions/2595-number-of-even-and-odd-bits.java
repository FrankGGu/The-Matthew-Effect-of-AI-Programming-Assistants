class Solution {
    public int[] evenOddBit(int n) {
        int evenCount = 0;
        int oddCount = 0;
        int position = 0;

        while (n > 0) {
            if ((n & 1) == 1) { // Check the least significant bit
                if (position % 2 == 0) { // Even position
                    evenCount++;
                } else { // Odd position
                    oddCount++;
                }
            }
            n >>= 1; // Move to the next bit
            position++; // Increment position
        }

        return new int[]{evenCount, oddCount};
    }
}