class Solution {
    public int minimumOneBitOperations(int n) {
        int mask = 1, result = 0;
        while (mask <= n) {
            mask <<= 1;
        }
        while (mask > 0) {
            if ((n & mask) != 0) {
                result ^= mask;
            }
            mask >>= 1;
        }
        return result;
    }
}