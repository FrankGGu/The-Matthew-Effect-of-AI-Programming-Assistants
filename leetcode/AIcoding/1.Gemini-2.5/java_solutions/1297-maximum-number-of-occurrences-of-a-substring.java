import java.util.HashMap;
import java.util.Map;

class Solution {
    public int maxFreq(String s, int maxLetters, int minSize, int maxSize) {
        int maxCount = 0;
        Map<String, Integer> freqMap = new HashMap<>();
        int[] charCounts = new int[26];
        int uniqueChars = 0;

        // Initialize the first window
        for (int i = 0; i < minSize; i++) {
            char c = s.charAt(i);
            if (charCounts[c - 'a'] == 0) {
                uniqueChars++;
            }
            charCounts[c - 'a']++;
        }

        // Check the first window
        if (uniqueChars <= maxLetters) {
            String sub = s.substring(0, minSize);
            freqMap.put(sub, freqMap.getOrDefault(sub, 0) + 1);
            maxCount = Math.max(maxCount, freqMap.get(sub));
        }

        // Slide the window
        for (int i = 1; i <= s.length() - minSize; i++) {
            // Remove character at (i-1)
            char charToRemove = s.charAt(i - 1);
            charCounts[charToRemove - 'a']--;
            if (charCounts[charToRemove - 'a'] == 0) {
                uniqueChars--;
            }

            // Add character at (i + minSize - 1)
            char charToAdd = s.charAt(i + minSize - 1);
            if (charCounts[charToAdd - 'a'] == 0) {
                uniqueChars++;
            }
            charCounts[charToAdd - 'a']++;

            // Check the current window
            if (uniqueChars <= maxLetters) {
                String sub = s.substring(i, i + minSize);
                freqMap.put(sub, freqMap.getOrDefault(sub, 0) + 1);
                maxCount = Math.max(maxCount, freqMap.get(sub));
            }
        }

        return maxCount;
    }
}