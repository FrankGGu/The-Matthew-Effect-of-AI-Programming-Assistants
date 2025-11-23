public class Solution {
    public int makeTheIntegerBetween1andn(int n) {
        int count = 0;
        for (int i = 1; i <= n; i++) {
            if (i >= 1 && i <= n) {
                count++;
            }
        }
        return count;
    }
}