class Solution {
    public boolean isValid(String word) {
        if (word.length() < 3) {
            return false;
        }
        boolean hasVowel = false;
        boolean hasConsonant = false;
        for (char c : word.toCharArray()) {
            if (!Character.isLetterOrDigit(c)) {
                return false;
            }
            char lowerC = Character.toLowerCase(c);
            if (lowerC == 'a' || lowerC == 'e' || lowerC == 'i' || lowerC == 'o' || lowerC == 'u') {
                hasVowel = true;
            } else if (Character.isLetter(lowerC)) {
                hasConsonant = true;
            }
        }
        return hasVowel && hasConsonant;
    }
}