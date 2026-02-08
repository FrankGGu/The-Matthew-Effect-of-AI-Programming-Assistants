public class Solution {
    public int findLUSlength(String a, String b) {
        if (a.length() != b.length()) {
            return Math.max(a.length(), b.length());
        } else {
            return a.equals(b) ? -1 : a.length();
        }
    }
}