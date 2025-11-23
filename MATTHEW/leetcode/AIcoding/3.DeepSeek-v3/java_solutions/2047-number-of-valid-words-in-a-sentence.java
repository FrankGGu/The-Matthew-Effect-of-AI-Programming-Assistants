class Solution {
    public int countValidWords(String sentence) {
        String[] tokens = sentence.split("\\s+");
        int count = 0;
        for (String token : tokens) {
            if (token.isEmpty()) continue;
            if (isValid(token)) {
                count++;
            }
        }
        return count;
    }

    private boolean isValid(String token) {
        int hyphenCount = 0;
        int punctuationCount = 0;
        for (int i = 0; i < token.length(); i++) {
            char c = token.charAt(i);
            if (Character.isDigit(c)) {
                return false;
            }
            if (c == '-') {
                if (i == 0 || i == token.length() - 1) {
                    return false;
                }
                if (!Character.isLetter(token.charAt(i - 1)) {
                    return false;
                }
                if (!Character.isLetter(token.charAt(i + 1))) {
                    return false;
                }
                hyphenCount++;
                if (hyphenCount > 1) {
                    return false;
                }
            }
            if (c == '!' || c == '.' || c == ',') {
                if (i != token.length() - 1) {
                    return false;
                }
                punctuationCount++;
                if (punctuationCount > 1) {
                    return false;
                }
            }
        }
        return true;
    }
}