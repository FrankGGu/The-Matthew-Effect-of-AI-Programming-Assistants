public class Solution {
    public int total appealSum(String s) {
        int n = s.length();
        int result = 0;
        int[] last = new int[26];
        for (int i = 0; i < 26; i++) {
            last[i] = -1;
        }
        for (int i = 0; i < n; i++) {
            int c = s.charAt(i) - 'a';
            int prev = last[c];
            result += (i - prev) * (n - i);
            last[c] = i;
        }
        return result;
    }
}