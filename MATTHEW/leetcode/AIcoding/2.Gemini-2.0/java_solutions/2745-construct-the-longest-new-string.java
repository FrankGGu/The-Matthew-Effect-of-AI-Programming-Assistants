class Solution {
    public int longestString(int x, int y, int z) {
        int ans = 0;
        if (x == y) {
            ans = (x + y + z) * 2;
        } else if (x > y) {
            ans = (y + y + z + 1) * 2;
        } else {
            ans = (x + x + z + 1) * 2;
        }
        return ans;
    }
}