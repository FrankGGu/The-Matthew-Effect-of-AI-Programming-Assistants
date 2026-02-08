public class Solution {
    public String gcdOfStrings(String s1, String s2) {
        if (s1.length() < s2.length()) {
            return gcdOfStrings(s2, s1);
        }
        if (!s1.startsWith(s2)) {
            return "";
        }
        if (s2.isEmpty()) {
            return s1;
        }
        return gcdOfStrings(s2, s1.substring(s2.length()));
    }
}