public class Solution {
    public boolean areAlmostEqual(String s, String t) {
        if (s.length() != t.length()) {
            return false;
        }
        int count = 0;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) != t.charAt(i)) {
                count++;
                if (count > 2) {
                    return false;
                }
            }
        }
        return count == 2 || count == 0;
    }
}