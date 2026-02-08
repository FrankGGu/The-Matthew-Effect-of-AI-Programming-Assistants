import java.util.*;

class Solution {
    public String findMostFrequentVowelAndConsonant(String s) {
        Set<Character> vowels = new HashSet<>(Arrays.asList('a', 'e', 'i', 'o', 'u'));
        Map<Character, Integer> vowelCount = new HashMap<>();
        Map<Character, Integer> consonantCount = new HashMap<>();

        int maxVowelCount = 0;
        char maxVowel = 'a';
        int maxConsonantCount = 0;
        char maxConsonant = 'b';

        for (char c : s.toLowerCase().toCharArray()) {
            if (Character.isLetter(c)) {
                if (vowels.contains(c)) {
                    vowelCount.put(c, vowelCount.getOrDefault(c, 0) + 1);
                    if (vowelCount.get(c) > maxVowelCount || 
                        (vowelCount.get(c) == maxVowelCount && c < maxVowel)) {
                        maxVowelCount = vowelCount.get(c);
                        maxVowel = c;
                    }
                } else {
                    consonantCount.put(c, consonantCount.getOrDefault(c, 0) + 1);
                    if (consonantCount.get(c) > maxConsonantCount || 
                        (consonantCount.get(c) == maxConsonantCount && c < maxConsonant)) {
                        maxConsonantCount = consonantCount.get(c);
                        maxConsonant = c;
                    }
                }
            }
        }

        if (maxVowelCount == 0) maxVowel = 'a';
        if (maxConsonantCount == 0) maxConsonant = 'b';

        return "" + maxVowel + maxConsonant;
    }
}