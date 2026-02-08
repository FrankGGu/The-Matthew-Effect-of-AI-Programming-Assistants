public class Solution {
    public int hasPrefixAtLeastOnce(int n, int[] flips) {
        int count = 0;
        int max = 0;
        for (int i = 0; i < n; i++) {
            max = Math.max(max, flips[i]);
            if (max == i + 1) {
                count++;
            }
        }
        return count;
    }
}