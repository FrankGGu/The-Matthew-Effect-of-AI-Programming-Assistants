class Solution {
    public String decodeMessage(String key, String message) {
        char[] mapping = new char[26];
        int count = 0;
        for (char c : key.toCharArray()) {
            if (c != ' ' && mapping[c - 'a'] == '\0') {
                mapping[c - 'a'] = (char) ('a' + count);
                count++;
            }
        }

        StringBuilder decodedMessage = new StringBuilder();
        for (char c : message.toCharArray()) {
            if (c == ' ') {
                decodedMessage.append(' ');
            } else {
                decodedMessage.append(mapping[c - 'a']);
            }
        }

        return decodedMessage.toString();
    }
}