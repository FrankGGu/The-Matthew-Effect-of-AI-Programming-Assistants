class Solution {
    public int longestString(int x, int y, int z) {
        int minXY = Math.min(x, y);
        if (x == y) {
            return (minXY * 2 + z) * 2;
        } else {
            return (minXY * 2 + 1 + z) * 2;
        }
    }
}