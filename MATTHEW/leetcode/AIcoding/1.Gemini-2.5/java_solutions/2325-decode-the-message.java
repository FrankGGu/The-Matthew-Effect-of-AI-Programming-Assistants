class Solution {
    public String decodeMessage(String key, String message) {
        char[] mapping = new char[26];
        char currentAlphabetChar = 'a';

        for (char kChar : key.toCharArray()) {
            if (kChar == ' ') {
                continue;
            }

            int index = kChar - 'a';
            if (mapping[index] == 0) {
                mapping[index] = currentAlphabetChar;
                currentAlphabetChar++;
                if (currentAlphabetChar > 'z') {
                    break;
                }
            }
        }

        StringBuilder decodedMessage = new StringBuilder();
        for (char mChar : message.toCharArray()) {
            if (mChar == ' ') {
                decodedMessage.append(' ');
            } else {
                decodedMessage.append(mapping[mChar - 'a']);
            }
        }

        return decodedMessage.toString();
    }
}