import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

class Solution {
    public boolean equalFrequency(String word) {
        Map<Character, Integer> charCounts = new HashMap<>();
        for (char c : word.toCharArray()) {
            charCounts.put(c, charCounts.getOrDefault(c, 0) + 1);
        }

        for (char c = 'a'; c <= 'z'; c++) {
            if (charCounts.containsKey(c)) {
                charCounts.put(c, charCounts.get(c) - 1);

                if (isValid(charCounts)) {
                    return true;
                }

                charCounts.put(c, charCounts.get(c) + 1);
            }
        }

        return false;
    }

    private boolean isValid(Map<Character, Integer> charCounts) {
        Set<Integer> distinctFrequencies = new HashSet<>();
        for (int count : charCounts.values()) {
            if (count > 0) {
                distinctFrequencies.add(count);
            }
        }
        return distinctFrequencies.size() == 1;
    }
}