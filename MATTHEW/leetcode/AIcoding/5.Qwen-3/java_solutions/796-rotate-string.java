public class Solution {
    public boolean rotateString(String a, String b) {
        if (a.length() != b.length()) {
            return false;
        }
        return (a + a).contains(b);
    }
}