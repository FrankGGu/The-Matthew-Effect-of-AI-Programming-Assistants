class Solution {
    public String freqAlphabets(String s) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            if (i + 2 < s.length() && s.charAt(i + 2) == '#') {
                int num = Integer.parseInt(s.substring(i, i + 2));
                sb.append((char) ('a' + num - 1));
                i += 2;
            } else {
                int num = s.charAt(i) - '0';
                sb.append((char) ('a' + num - 1));
            }
        }
        return sb.toString();
    }
}