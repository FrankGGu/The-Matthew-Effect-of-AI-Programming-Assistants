class Solution {
    public int countValidWords(String sentence) {
        int validWordsCount = 0;
        String[] words = sentence.split("\\s+"); // Split by one or more spaces

        for (String word : words) {
            if (word.isEmpty()) {
                continue;
            }
            if (isValid(word)) {
                validWordsCount++;
            }
        }
        return validWordsCount;
    }

    private boolean isValid(String word) {
        int hyphenCount = 0;
        int punctuationCount = 0;

        for (int i = 0; i < word.length(); i++) {
            char c = word.charAt(i);

            if (Character.isDigit(c)) {
                return false; // Contains a digit
            }

            if (c == '-') {
                hyphenCount++;
                if (hyphenCount > 1) {
                    return false; // More than one hyphen
                }
                // Hyphen cannot be at the start or end
                // And must be surrounded by lowercase letters
                if (i == 0 || i == word.length() - 1 || 
                    !Character.isLowerCase(word.charAt(i - 1)) || 
                    !Character.isLowerCase(word.charAt(i + 1))) {
                    return false;
                }
            } else if (c == '.' || c == '!' || c == ',') {
                punctuationCount++;
                if (punctuationCount > 1) {
                    return false; // More than one punctuation mark
                }
                // Punctuation mark must be at the end of the word
                if (i != word.length() - 1) {
                    return false;
                }
            } else if (!Character.isLowerCase(c)) {
                // Any other character that is not a lowercase letter, hyphen, or allowed punctuation
                return false;
            }
        }
        return true; // All checks passed
    }
}