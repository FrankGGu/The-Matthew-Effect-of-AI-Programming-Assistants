public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public String[] findMostFrequentVowelAndConsonant(String s) {
        Map<Character, Integer> vowelCount = new HashMap<>();
        Map<Character, Integer> consonantCount = new HashMap<>();

        for (char c : s.toCharArray()) {
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                vowelCount.put(c, vowelCount.getOrDefault(c, 0) + 1);
            } else if (Character.isLetter(c)) {
                consonantCount.put(c, consonantCount.getOrDefault(c, 0) + 1);
            }
        }

        char maxVowel = ' ';
        int maxVowelCount = 0;
        for (Map.Entry<Character, Integer> entry : vowelCount.entrySet()) {
            if (entry.getValue() > maxVowelCount) {
                maxVowelCount = entry.getValue();
                maxVowel = entry.getKey();
            }
        }

        char maxConsonant = ' ';
        int maxConsonantCount = 0;
        for (Map.Entry<Character, Integer> entry : consonantCount.entrySet()) {
            if (entry.getValue() > maxConsonantCount) {
                maxConsonantCount = entry.getValue();
                maxConsonant = entry.getKey();
            }
        }

        return new String[]{String.valueOf(maxVowel), String.valueOf(maxConsonant)};
    }
}
}