import java.util.HashMap;
import java.util.Map;

public class Solution {
    public String mostFrequent(String s) {
        Map<Character, Integer> vowelMap = new HashMap<>();
        Map<Character, Integer> consonantMap = new HashMap<>();

        for (char c : s.toCharArray()) {
            if (Character.isLetter(c)) {
                char lowerChar = Character.toLowerCase(c);
                if ("aeiou".indexOf(lowerChar) >= 0) {
                    vowelMap.put(lowerChar, vowelMap.getOrDefault(lowerChar, 0) + 1);
                } else {
                    consonantMap.put(lowerChar, consonantMap.getOrDefault(lowerChar, 0) + 1);
                }
            }
        }

        char mostFrequentVowel = ' ';
        char mostFrequentConsonant = ' ';
        int maxVowelCount = 0;
        int maxConsonantCount = 0;

        for (Map.Entry<Character, Integer> entry : vowelMap.entrySet()) {
            if (entry.getValue() > maxVowelCount) {
                maxVowelCount = entry.getValue();
                mostFrequentVowel = entry.getKey();
            }
        }

        for (Map.Entry<Character, Integer> entry : consonantMap.entrySet()) {
            if (entry.getValue() > maxConsonantCount) {
                maxConsonantCount = entry.getValue();
                mostFrequentConsonant = entry.getKey();
            }
        }

        return "" + mostFrequentVowel + mostFrequentConsonant;
    }
}