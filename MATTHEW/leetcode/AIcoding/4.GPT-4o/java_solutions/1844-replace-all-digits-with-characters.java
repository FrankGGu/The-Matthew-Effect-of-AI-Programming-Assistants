class Solution {
    public String replaceDigits(String s) {
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            result.append(c);
            if (i % 2 == 1) {
                result.append((char)(c + (s.charAt(i) - '0')));
            }
        }
        return result.toString();
    }
}