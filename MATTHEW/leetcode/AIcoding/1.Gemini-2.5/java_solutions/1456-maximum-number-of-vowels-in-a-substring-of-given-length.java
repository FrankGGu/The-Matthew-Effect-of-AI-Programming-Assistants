class Solution {
    public int maxVowels(String s, int k) {
        int maxVowelsCount = 0;
        int currentVowelsCount = 0;

        for (int i = 0; i < k; i++) {
            if (isVowel(s.charAt(i))) {
                currentVowelsCount++;
            }
        }

        maxVowelsCount = currentVowelsCount;

        for (int i = k; i < s.length(); i++) {
            if (isVowel(s.charAt(i - k))) {
                currentVowelsCount--;
            }
            if (isVowel(s.charAt(i))) {
                currentVowelsCount++;
            }
            maxVowelsCount = Math.max(maxVowelsCount, currentVowelsCount);
        }

        return maxVowelsCount;
    }

    private boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }
}