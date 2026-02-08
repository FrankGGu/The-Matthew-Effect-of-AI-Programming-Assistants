class Solution {
    public int vowelStrings(String[] words, int left, int right) {
        int count = 0;
        for (int i = left; i <= right; i++) {
            String word = words[i];
            char firstChar = word.charAt(0);
            char lastChar = word.charAt(word.length() - 1);

            if (isVowel(firstChar) && isVowel(lastChar)) {
                count++;
            }
        }
        return count;
    }

    private boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }
}