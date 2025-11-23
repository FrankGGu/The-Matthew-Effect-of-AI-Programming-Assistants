public class Solution {
    public String hashDividedString(String s, int k) {
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            if (i > 0 && i % k == 0) {
                result.append('-');
            }
            result.append(s.charAt(i));
        }
        return result.toString();
    }
}