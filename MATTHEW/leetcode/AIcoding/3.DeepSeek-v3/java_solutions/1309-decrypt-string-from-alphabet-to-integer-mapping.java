class Solution {
    public String freqAlphabets(String s) {
        StringBuilder sb = new StringBuilder();
        int i = 0;
        int n = s.length();
        while (i < n) {
            if (i + 2 < n && s.charAt(i + 2) == '#') {
                int num = Integer.parseInt(s.substring(i, i + 2));
                sb.append((char) (num + 'a' - 1));
                i += 3;
            } else {
                int num = s.charAt(i) - '0';
                sb.append((char) (num + 'a' - 1));
                i++;
            }
        }
        return sb.toString();
    }
}