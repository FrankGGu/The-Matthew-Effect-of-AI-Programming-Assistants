class Solution {
    public int countValidWords(String sentence) {
        String[] words = sentence.split(" ");
        int count = 0;

        for (String word : words) {
            if (word.isEmpty()) continue;
            if (isValid(word)) count++;
        }

        return count;
    }

    private boolean isValid(String word) {
        int hyphenCount = 0, punctuationCount = 0;
        for (int i = 0; i < word.length(); i++) {
            char c = word.charAt(i);
            if (Character.isDigit(c)) return false;
            if (c == '-') {
                hyphenCount++;
                if (hyphenCount > 1 || i == 0 || i == word.length() - 1 || word.charAt(i - 1) == '-' || word.charAt(i + 1) == '-') {
                    return false;
                }
            } else if (c == '!' || c == '.' || c == ',') {
                punctuationCount++;
                if (punctuationCount > 1 || i != word.length() - 1) {
                    return false;
                }
            }
        }
        return true;
    }
}