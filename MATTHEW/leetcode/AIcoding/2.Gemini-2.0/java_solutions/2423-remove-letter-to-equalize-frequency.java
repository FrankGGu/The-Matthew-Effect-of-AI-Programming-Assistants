import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

class Solution {
    public boolean equalFrequency(String word) {
        for (int i = 0; i < word.length(); i++) {
            StringBuilder sb = new StringBuilder(word);
            sb.deleteCharAt(i);
            String temp = sb.toString();
            if (temp.length() == 0) return true;

            Map<Character, Integer> freq = new HashMap<>();
            for (char c : temp.toCharArray()) {
                freq.put(c, freq.getOrDefault(c, 0) + 1);
            }

            Set<Integer> distinctFrequencies = new HashSet<>(freq.values());
            if (distinctFrequencies.size() == 1) {
                return true;
            }
        }
        return false;
    }
}