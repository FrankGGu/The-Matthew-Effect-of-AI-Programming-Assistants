import java.util.PriorityQueue;
import java.util.Map;
import java.util.HashMap;

class Solution {
    public String reorganizeString(String s) {
        Map<Character, Integer> counts = new HashMap<>();
        for (char c : s.toCharArray()) {
            counts.put(c, counts.getOrDefault(c, 0) + 1);
        }

        PriorityQueue<Character> maxHeap = new PriorityQueue<>((a, b) -> counts.get(b) - counts.get(a));
        maxHeap.addAll(counts.keySet());

        StringBuilder result = new StringBuilder();
        while (maxHeap.size() > 1) {
            char char1 = maxHeap.poll();
            char char2 = maxHeap.poll();

            result.append(char1);
            result.append(char2);

            counts.put(char1, counts.get(char1) - 1);
            counts.put(char2, counts.get(char2) - 1);

            if (counts.get(char1) > 0) {
                maxHeap.add(char1);
            }
            if (counts.get(char2) > 0) {
                maxHeap.add(char2);
            }
        }

        if (!maxHeap.isEmpty()) {
            char lastChar = maxHeap.poll();
            if (counts.get(lastChar) > 1) {
                return "";
            }
            result.append(lastChar);
        }

        return result.toString();
    }
}