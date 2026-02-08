class Solution {
    public int maxFreq(String s, int maxLetters, int minSize, int maxSize) {
        int n = s.length();
        if (n < minSize) {
            return 0;
        }

        int maxFrequency = 0;
        for (int len = minSize; len <= Math.min(maxSize, n); len++) {
            for (int i = 0; i <= n - len; i++) {
                String sub = s.substring(i, i + len);
                if (isValid(sub, maxLetters)) {
                    int frequency = countOccurrences(s, sub);
                    maxFrequency = Math.max(maxFrequency, frequency);
                }
            }
        }

        return maxFrequency;
    }

    private boolean isValid(String s, int maxLetters) {
        int[] charCount = new int[26];
        int distinctLetters = 0;
        for (char c : s.toCharArray()) {
            int index = c - 'a';
            if (charCount[index] == 0) {
                distinctLetters++;
            }
            charCount[index]++;
        }
        return distinctLetters <= maxLetters;
    }

    private int countOccurrences(String text, String pattern) {
        int count = 0;
        for (int i = 0; i <= text.length() - pattern.length(); i++) {
            if (text.substring(i, i + pattern.length()).equals(pattern)) {
                count++;
            }
        }
        return count;
    }
}