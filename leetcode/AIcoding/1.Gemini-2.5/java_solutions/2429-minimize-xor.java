class Solution {
    public int minimizeXor(int num1, int num2) {
        int setBits2 = Integer.bitCount(num2);
        int x = 0;

        // First pass: try to match set bits of num1 from MSB to LSB.
        // This minimizes the XOR value by making x as close to num1 as possible.
        // We prioritize setting bits in x at positions where num1 also has a set bit.
        for (int i = 30; i >= 0 && setBits2 > 0; i--) {
            if (((num1 >> i) & 1) == 1) { // If the i-th bit of num1 is set
                x |= (1 << i); // Set the i-th bit of x
                setBits2--;
            }
        }

        // Second pass: if setBits2 is still greater than 0, it means we need to set more bits in x.
        // These remaining bits must be set to satisfy the count requirement.
        // Set these bits from LSB to MSB at positions where x does not already have a bit set.
        // This ensures the smallest possible increase in the XOR value by affecting less significant bits.
        for (int i = 0; i <= 30 && setBits2 > 0; i++) {
            if (((x >> i) & 1) == 0) { // If the i-th bit of x is not set
                x |= (1 << i); // Set the i-th bit of x
                setBits2--;
            }
        }

        return x;
    }
}