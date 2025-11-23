class Solution {
    public int longestString(int x, int y, int z) {
        int totalA = 2 * x + z;
        int totalB = 2 * y + z;

        if (totalA == totalB) {
            return 2 * totalA;
        } else {
            return 2 * Math.min(totalA, totalB) + 1;
        }
    }
}