import java.lang.StringBuilder;

class Solution {
    public String minBooths(String[] words) {
        int[] maxFrequencies = new int[26];

        for (String word : words) {
            int[] currentWordFrequencies = new int[26];
            for (char c : word.toCharArray()) {
                currentWordFrequencies[c - 'a']++;
            }

            for (int i = 0; i < 26; i++) {
                maxFrequencies[i] = Math.max(maxFrequencies[i], currentWordFrequencies[i]);
            }
        }

        StringBuilder result = new StringBuilder();
        for (int i = 0; i < 26; i++) {
            char c = (char) ('a' + i);
            for (int j = 0; j < maxFrequencies[i]; j++) {
                result.append(c);
            }
        }

        return result.toString();
    }
}