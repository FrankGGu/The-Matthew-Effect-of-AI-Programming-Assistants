public class Solution {

import java.util.*;

public class Solution {
    public String minimizeConcatenation(List<String> arr) {
        Map<Character, Integer> count = new HashMap<>();
        for (String s : arr) {
            for (char c : s.toCharArray()) {
                count.put(c, count.getOrDefault(c, 0) + 1);
            }
        }

        PriorityQueue<Map.Entry<Character, Integer>> pq = new PriorityQueue<>((a, b) -> {
            int cmp = Integer.compare(b.getValue(), a.getValue());
            if (cmp != 0) return cmp;
            return a.getKey() - b.getKey();
        });

        for (Map.Entry<Character, Integer> entry : count.entrySet()) {
            pq.offer(entry);
        }

        StringBuilder result = new StringBuilder();
        while (!pq.isEmpty()) {
            Map.Entry<Character, Integer> entry = pq.poll();
            char c = entry.getKey();
            int freq = entry.getValue();
            for (int i = 0; i < freq; i++) {
                result.append(c);
            }
        }

        return result.toString();
    }
}
}