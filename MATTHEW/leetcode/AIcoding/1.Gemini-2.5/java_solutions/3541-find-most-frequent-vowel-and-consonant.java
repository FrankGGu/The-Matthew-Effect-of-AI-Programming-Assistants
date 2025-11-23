import java.util.HashSet;
import java.util.Set;

class Solution {
    public char[] findMostFrequentVowelAndConsonant(String s) {
        // Frequency arrays for 'a' through 'z'
        int[] vowelCounts = new int[26];
        int[] consonantCounts = new int[26];

        // Define vowels set for quick lookup
        Set<Character> vowels = new HashSet<>();
        vowels.add('a');
        vowels.add('e');
        vowels.add('i');
        vowels.add('o');
        vowels.add('u');

        // Populate counts
        for (char ch : s.toCharArray()) {
            char lowerCh = Character.toLowerCase(ch);
            if (lowerCh >= 'a' && lowerCh <= 'z') {
                if (vowels.contains(lowerCh)) {
                    vowelCounts[lowerCh - 'a']++;
                } else {
                    consonantCounts[lowerCh - 'a']++;
                }
            }
        }

        // Find most frequent vowel
        char mostFrequentVowel = ' '; // Default value if no vowels found
        int maxVowelCount = -1;
        for (char c = 'a'; c <= 'z'; c++) {
            if (vowels.contains(c)) {
                int currentCount = vowelCounts[c - 'a'];
                if (currentCount > maxVowelCount) {
                    maxVowelCount = currentCount;
                    mostFrequentVowel = c;
                }
            }
        }

        // Find most frequent consonant
        char mostFrequentConsonant = ' '; // Default value if no consonants found
        int maxConsonantCount = -1;
        for (char c = 'a'; c <= 'z'; c++) {
            if (!vowels.contains(c)) { // It's a consonant
                int currentCount = consonantCounts[c - 'a'];
                if (currentCount > maxConsonantCount) {
                    maxConsonantCount = currentCount;
                    mostFrequentConsonant = c;
                }
            }
        }

        return new char[]{mostFrequentVowel, mostFrequentConsonant};
    }
}