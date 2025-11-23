class Solution {
    public boolean hasAlternatingBits(int n) {
        int prevBit = n & 1;
        n >>= 1;
        while (n > 0) {
            int currentBit = n & 1;
            if (currentBit == prevBit) {
                return false;
            }
            prevBit = currentBit;
            n >>= 1;
        }
        return true;
    }
}