import java.util.HashSet;
import java.util.Set;

class Solution {
    public int findSpecialSubstring(String s, int k) {
        int n = s.length();
        int count = 0;
        for (int i = 0; i <= n - k; i++) {
            String sub = s.substring(i, i + k);
            Set<Character> set = new HashSet<>();
            for (char c : sub.toCharArray()) {
                set.add(c);
            }
            if (set.size() == k) {
                count++;
            }
        }
        return count;
    }
}