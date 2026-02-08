class Solution {
    public long countVowels(String word) {
        long totalVowels = 0;
        int n = word.length();
        for (int i = 0; i < n; i++) {
            if (isVowel(word.charAt(i))) {
                totalVowels += (long)(i + 1) * (n - i);
            }
        }
        return totalVowels;
    }

    private boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }
}