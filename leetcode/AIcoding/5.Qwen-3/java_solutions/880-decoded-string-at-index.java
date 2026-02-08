public class Solution {
    public String decodeAtIndex(String s, int k) {
        long size = 0;
        for (char c : s.toCharArray()) {
            if (Character.isDigit(c)) {
                size *= (c - '0');
            } else {
                size++;
            }
        }

        for (int i = s.length() - 1; i >= 0; i--) {
            char c = s.charAt(i);
            if (Character.isDigit(c)) {
                size /= (c - '0');
            } else {
                if (size == k) {
                    return String.valueOf(c);
                }
                size--;
            }
        }
        return "";
    }
}