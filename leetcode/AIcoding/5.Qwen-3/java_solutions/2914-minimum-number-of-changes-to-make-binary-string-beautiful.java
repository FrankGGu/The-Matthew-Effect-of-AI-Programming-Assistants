public class Solution {
    public int minChanges(String s, int k) {
        int n = s.length();
        int[] count = new int[2];
        for (int i = 0; i < k; i++) {
            count[s.charAt(i) - '0']++;
        }
        int res = Math.min(count[0], count[1]);
        for (int i = k; i < n; i++) {
            count[s.charAt(i - k) - '0']--;
            count[s.charAt(i) - '0']++;
            res += Math.min(count[0], count[1]);
        }
        return res;
    }
}