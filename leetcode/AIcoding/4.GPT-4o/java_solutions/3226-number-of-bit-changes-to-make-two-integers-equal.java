public class Solution {
    public int countBitFlips(int start, int goal) {
        return Integer.bitCount(start ^ goal);
    }
}