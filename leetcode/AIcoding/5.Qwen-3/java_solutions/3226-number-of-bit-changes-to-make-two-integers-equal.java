public class Solution {
    public int minChanges(int n, int k) {
        int changes = 0;
        while (n > 0 || k > 0) {
            if ((n & 1) != (k & 1)) {
                changes++;
            }
            n >>= 1;
            k >>= 1;
        }
        return changes;
    }
}