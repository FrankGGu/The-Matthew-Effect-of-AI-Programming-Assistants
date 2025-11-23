public class Solution {
    public int bulbSwitcherII(int n, int m) {
        if (m == 0) return 0;
        int count = 0;
        for (int i = 1; i <= n; i++) {
            if (i % m == 0) {
                count++;
            }
        }
        return count;
    }
}