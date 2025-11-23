public class Solution {

import java.util.*;

public class Solution {
    public String frequencySort(String s) {
        Map<Character, Integer> freqMap = new HashMap<>();
        for (char c : s.toCharArray()) {
            freqMap.put(c, freqMap.getOrDefault(c, 0) + 1);
        }

        List<Character> characters = new ArrayList<>(freqMap.keySet());
        characters.sort((a, b) -> freqMap.get(b) - freqMap.get(a));

        StringBuilder sb = new StringBuilder();
        for (char c : characters) {
            int count = freqMap.get(c);
            for (int i = 0; i < count; i++) {
                sb.append(c);
            }
        }

        return sb.toString();
    }
}
}