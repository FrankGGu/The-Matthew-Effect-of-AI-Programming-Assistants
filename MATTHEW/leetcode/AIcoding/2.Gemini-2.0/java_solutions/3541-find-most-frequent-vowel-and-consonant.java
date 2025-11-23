import java.util.HashMap;
import java.util.Map;

class Solution {
    public String mostFrequentVowelAndConsonant(String s) {
        Map<Character, Integer> vowelCounts = new HashMap<>();
        Map<Character, Integer> consonantCounts = new HashMap<>();
        String vowels = "aeiou";

        for (char c : s.toLowerCase().toCharArray()) {
            if (Character.isLetter(c)) {
                if (vowels.indexOf(c) != -1) {
                    vowelCounts.put(c, vowelCounts.getOrDefault(c, 0) + 1);
                } else {
                    consonantCounts.put(c, consonantCounts.getOrDefault(c, 0) + 1);
                }
            }
        }

        char mostFrequentVowel = ' ';
        int maxVowelCount = 0;
        for (Map.Entry<Character, Integer> entry : vowelCounts.entrySet()) {
            if (entry.getValue() > maxVowelCount) {
                mostFrequentVowel = entry.getKey();
                maxVowelCount = entry.getValue();
            } else if (entry.getValue() == maxVowelCount && entry.getKey() < mostFrequentVowel) {
                mostFrequentVowel = entry.getKey();
            }
        }

        char mostFrequentConsonant = ' ';
        int maxConsonantCount = 0;
        for (Map.Entry<Character, Integer> entry : consonantCounts.entrySet()) {
            if (entry.getValue() > maxConsonantCount) {
                mostFrequentConsonant = entry.getKey();
                maxConsonantCount = entry.getValue();
            } else if (entry.getValue() == maxConsonantCount && entry.getKey() < mostFrequentConsonant) {
                mostFrequentConsonant = entry.getKey();
            }
        }

        if (maxVowelCount == 0 && maxConsonantCount == 0) {
            return "";
        } else if (maxVowelCount == 0) {
            return String.valueOf(mostFrequentConsonant);
        } else if (maxConsonantCount == 0) {
            return String.valueOf(mostFrequentVowel);
        } else {
            return String.valueOf(mostFrequentVowel) + mostFrequentConsonant;
        }
    }
}