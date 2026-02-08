public class Solution {
    public String decodeMessage(String key, String message) {
        StringBuilder result = new StringBuilder();
        char[] mapping = new char[26];
        boolean[] used = new boolean[26];
        int index = 0;

        for (char c : key.toCharArray()) {
            if (c == ' ') continue;
            if (!used[c - 'a']) {
                mapping[c - 'a'] = (char) ('a' + index);
                used[c - 'a'] = true;
                index++;
            }
        }

        for (char c : message.toCharArray()) {
            if (c == ' ') {
                result.append(' ');
            } else {
                result.append(mapping[c - 'a']);
            }
        }

        return result.toString();
    }
}