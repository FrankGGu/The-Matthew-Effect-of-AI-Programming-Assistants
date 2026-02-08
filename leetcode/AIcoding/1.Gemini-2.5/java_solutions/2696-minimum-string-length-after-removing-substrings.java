class Solution {
    public int minLength(String s) {
        StringBuilder sb = new StringBuilder();
        for (char c : s.toCharArray()) {
            if (sb.length() > 0) {
                char lastChar = sb.charAt(sb.length() - 1);
                if ((lastChar == 'A' && c == 'B') || (lastChar == 'C' && c == 'D')) {
                    sb.deleteCharAt(sb.length() - 1);
                } else {
                    sb.append(c);
                }
            } else {
                sb.append(c);
            }
        }
        return sb.length();
    }
}