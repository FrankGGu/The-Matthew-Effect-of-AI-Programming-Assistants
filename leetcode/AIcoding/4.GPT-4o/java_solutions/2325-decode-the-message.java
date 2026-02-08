class Solution {
    public String decodeMessage(String key, String message) {
        char[] mapping = new char[26];
        boolean[] used = new boolean[26];
        int idx = 0;

        for (char c : key.toCharArray()) {
            if (c != ' ' && !used[c - 'a']) {
                mapping[c - 'a'] = (char) ('a' + idx);
                used[c - 'a'] = true;
                idx++;
            }
        }

        StringBuilder decoded = new StringBuilder();
        for (char c : message.toCharArray()) {
            if (c == ' ') {
                decoded.append(' ');
            } else {
                decoded.append(mapping[c - 'a']);
            }
        }

        return decoded.toString();
    }
}