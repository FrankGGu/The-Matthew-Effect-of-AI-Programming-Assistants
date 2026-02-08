class Solution {
    public long numberOfWays(String s) {
        long totalZeros = 0;
        long totalOnes = 0;
        for (char c : s.toCharArray()) {
            if (c == '0') {
                totalZeros++;
            } else {
                totalOnes++;
            }
        }

        long ans = 0;
        long zerosLeft = 0;
        long onesLeft = 0;

        for (char c : s.toCharArray()) {
            if (c == '0') {
                // Current building is '0'. We are looking for '101' pattern.
                // This '0' is the middle building.
                // We need '1's to its left (onesLeft) and '1's to its right.
                // '1's to its right = totalOnes - onesLeft (since current is '0', it doesn't affect ones count)
                long onesRight = totalOnes - onesLeft;
                ans += onesLeft * onesRight;
                zerosLeft++;
            } else { // c == '1'
                // Current building is '1'. We are looking for '010' pattern.
                // This '1' is the middle building.
                // We need '0's to its left (zerosLeft) and '0's to its right.
                // '0's to its right = totalZeros - zerosLeft (since current is '1', it doesn't affect zeros count)
                long zerosRight = totalZeros - zerosLeft;
                ans += zerosLeft * zerosRight;
                onesLeft++;
            }
        }
        return ans;
    }
}