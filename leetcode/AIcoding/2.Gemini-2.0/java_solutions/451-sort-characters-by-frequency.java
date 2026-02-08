import java.util.*;

class Solution {
    public String frequencySort(String s) {
        Map<Character, Integer> charFrequency = new HashMap<>();
        for (char c : s.toCharArray()) {
            charFrequency.put(c, charFrequency.getOrDefault(c, 0) + 1);
        }

        PriorityQueue<Character> maxHeap = new PriorityQueue<>((a, b) -> charFrequency.get(b) - charFrequency.get(a));
        maxHeap.addAll(charFrequency.keySet());

        StringBuilder sortedString = new StringBuilder();
        while (!maxHeap.isEmpty()) {
            char c = maxHeap.poll();
            int frequency = charFrequency.get(c);
            for (int i = 0; i < frequency; i++) {
                sortedString.append(c);
            }
        }

        return sortedString.toString();
    }
}