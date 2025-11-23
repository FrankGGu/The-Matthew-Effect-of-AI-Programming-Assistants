class Solution {
    public String freqAlphabets(String s) {
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            if (i + 2 < s.length() && s.charAt(i + 2) == '#') {
                result.append((char) ('a' + Integer.parseInt(s.substring(i, i + 2)) - 1));
                i += 2;
            } else {
                result.append((char) ('a' + s.charAt(i) - '1'));
            }
        }
        return result.toString();
    }
}