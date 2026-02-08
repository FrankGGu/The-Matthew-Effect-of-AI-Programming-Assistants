import java.util.HashSet;

public class Solution {
    public int distinctEchoSubstrings(String text) {
        HashSet<String> set = new HashSet<>();
        int n = text.length();
        for (int len = 1; len <= n / 2; len++) {
            for (int i = 0; i <= n - 2 * len; i++) {
                String s1 = text.substring(i, i + len);
                String s2 = text.substring(i + len, i + 2 * len);
                if (s1.equals(s2)) {
                    set.add(s1);
                }
            }
        }
        return set.size();
    }
}