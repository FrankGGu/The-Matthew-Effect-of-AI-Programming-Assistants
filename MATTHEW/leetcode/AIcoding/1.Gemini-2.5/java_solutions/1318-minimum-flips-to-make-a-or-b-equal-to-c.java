class Solution {
    public int minFlips(int a, int b, int c) {
        int flips = 0;

        for (int i = 0; i < 31; i++) { // Iterate through bits from 0 to 30 (max value 10^9 < 2^30)
            int bitA = (a >> i) & 1;
            int bitB = (b >> i) & 1;
            int bitC = (c >> i) & 1;

            if (bitC == 0) {
                // If the target bit in c is 0, then both corresponding bits in a and b must be 0.
                // Any 1 in bitA or bitB must be flipped.
                if (bitA == 1) {
                    flips++;
                }
                if (bitB == 1) {
                    flips++;
                }
            } else { // bitC == 1
                // If the target bit in c is 1, then at least one of the corresponding bits in a or b must be 1.
                // If both bitA and bitB are 0, we need to flip one of them to 1. This costs 1 flip.
                // If either bitA or bitB (or both) are already 1, no flips are needed for this bit position.
                if (bitA == 0 && bitB == 0) {
                    flips++;
                }
            }
        }
        return flips;
    }
}