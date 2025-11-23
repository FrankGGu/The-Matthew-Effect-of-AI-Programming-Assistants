class Solution {
    public String freqAlphabets(String s) {
        StringBuilder result = new StringBuilder();
        for (int i = s.length() - 1; i >= 0; ) {
            if (i > 1 && s.charAt(i) == '#') {
                int num = Integer.parseInt(s.substring(i - 2, i));
                result.append((char) ('a' + num - 1));
                i -= 3;
            } else {
                int num = s.charAt(i) - '0';
                result.append((char) ('a' + num - 1));
                i--;
            }
        }
        return result.reverse().toString();
    }
}