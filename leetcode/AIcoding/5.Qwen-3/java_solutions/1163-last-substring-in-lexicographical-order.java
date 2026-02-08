public class Solution {
    public String lastSubstring(String s) {
        int n = s.length();
        int i = 0, j = 1, k = 0;
        while (j + k < n) {
            if (s.charAt(i + k) == s.charAt(j + k)) {
                k++;
                continue;
            }
            if (s.charAt(i + k) < s.charAt(j + k)) {
                i = Math.max(i + k + 1, j);
            } else {
                j = j + k + 1;
            }
            k = 0;
        }
        return s.substring(i);
    }
}