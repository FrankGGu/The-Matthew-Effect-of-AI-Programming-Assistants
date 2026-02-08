public class Solution {
    public int maxHeight(int[] a, int[] b) {
        int n = a.length;
        int max = 0;
        int current = 0;
        for (int i = 0; i < n; i++) {
            current += a[i];
            max = Math.max(max, current);
            current -= b[i];
        }
        return max;
    }
}