import java.util.HashMap;
import java.util.Map;

class Solution {
    public int longestPalindrome(String[] words) {
        Map<String, Integer> counts = new HashMap<>();
        for (String word : words) {
            counts.put(word, counts.getOrDefault(word, 0) + 1);
        }

        int totalLength = 0;
        int maxOddPalindromicWordLength = 0;

        for (String word : counts.keySet()) {
            if (counts.get(word) == 0) {
                continue;
            }

            String reversedWord = new StringBuilder(word).reverse().toString();

            if (word.equals(reversedWord)) {
                // Palindromic word (e.g., "gg", "aba")
                int count = counts.get(word);

                // Use even number of these words for pairs
                totalLength += (count / 2) * 2 * word.length();

                // If there's an odd count, one can potentially be used as a center
                if (count % 2 == 1) {
                    maxOddPalindromicWordLength = Math.max(maxOddPalindromicWordLength, word.length());
                }

                // Mark as fully processed for pairing
                counts.put(word, 0); 
            } else {
                // Non-palindromic word (e.g., "lc", "cl")
                if (counts.containsKey(reversedWord)) {
                    int count1 = counts.get(word);
                    int count2 = counts.get(reversedWord);

                    int numPairs = Math.min(count1, count2);
                    totalLength += numPairs * 2 * word.length();

                    // Mark both as processed for these pairs
                    counts.put(word, count1 - numPairs);
                    counts.put(reversedWord, count2 - numPairs);
                }
            }
        }

        return totalLength + maxOddPalindromicWordLength;
    }
}