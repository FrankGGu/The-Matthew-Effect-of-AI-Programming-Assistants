import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> strStr(String text, String pattern) {
        List<Integer> result = new ArrayList<>();
        int n = text.length();
        int m = pattern.length();

        if (m == 0) {
            return result; // Or handle as per specific problem requirements for empty pattern
        }
        if (n < m) {
            return result;
        }

        // Step 1: Preprocess the pattern (compute LPS array)
        int[] lps = new int[m];
        int length = 0; // length of the longest proper prefix suffix
        int i = 1;
        while (i < m) {
            if (pattern.charAt(i) == pattern.charAt(length)) {
                length++;
                lps[i] = length;
                i++;
            } else {
                if (length != 0) {
                    length = lps[length - 1];
                } else {
                    lps[i] = 0;
                    i++;
                }
            }
        }

        // Step 2: Match pattern in text
        int textIdx = 0; // pointer for text
        int patternIdx = 0; // pointer for pattern
        while (textIdx < n) {
            if (pattern.charAt(patternIdx) == text.charAt(textIdx)) {
                textIdx++;
                patternIdx++;
            }

            if (patternIdx == m) { // Pattern found
                result.add(textIdx - patternIdx); // Add starting index
                patternIdx = lps[patternIdx - 1]; // Move patternIdx back using LPS array for next possible match
            } else if (textIdx < n && pattern.charAt(patternIdx) != text.charAt(textIdx)) {
                // Mismatch after patternIdx matches
                if (patternIdx != 0) {
                    patternIdx = lps[patternIdx - 1]; // Move patternIdx back using LPS array
                } else { // patternIdx is 0, no prefix to fall back to
                    textIdx++; // Just move textIdx pointer forward
                }
            }
        }
        return result;
    }
}