class Solution {
    public int countVowelStrings(int n) {
        return (int) Math.pow(5, n);
    }

    public int vowelStrings(String[] words, int left, int right) {
        int count = 0;
        for (int i = left; i <= right; i++) {
            String word = words[i];
            if (isVowelString(word)) {
                count++;
            }
        }
        return count;
    }

    private boolean isVowelString(String word) {
        return isVowel(word.charAt(0)) && isVowel(word.charAt(word.length() - 1));
    }

    private boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }
}