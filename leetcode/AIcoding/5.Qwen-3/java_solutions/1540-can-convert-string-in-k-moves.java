public class Solution {
    public boolean canConvertString(String s, String t) {
        if (s.length() != t.length()) {
            return false;
        }
        int[] count = new int[26];
        for (int i = 0; i < s.length(); i++) {
            char sc = s.charAt(i);
            char tc = t.charAt(i);
            if (sc == tc) {
                continue;
            }
            int diff = (tc - sc + 26) % 26;
            if (count[diff] >= 25) {
                return false;
            }
            count[diff]++;
        }
        return true;
    }
}