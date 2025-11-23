public class Solution {
    public int timeRequiredToRearrange(String s) {
        int n = s.length();
        int[] pos = new int[n];
        int count = 0;
        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == '1') {
                pos[count++] = i;
            }
        }
        int res = 0;
        for (int i = 0; i < count; i++) {
            int expected = i;
            if (pos[i] != expected) {
                res += Math.abs(pos[i] - expected);
            }
        }
        return res;
    }
}