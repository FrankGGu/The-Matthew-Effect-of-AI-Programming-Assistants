public class Solution {
    public int shiftDistance(String s, String t, int k) {
        int n = s.length();
        int m = t.length();
        if (n != m) return -1;
        int[] shift = new int[n];
        for (int i = 0; i < n; i++) {
            int diff = (t.charAt(i) - s.charAt(i) + k) % k;
            shift[i] = diff;
        }
        for (int i = 1; i < n; i++) {
            if (shift[i] != shift[0]) return -1;
        }
        return shift[0];
    }
}