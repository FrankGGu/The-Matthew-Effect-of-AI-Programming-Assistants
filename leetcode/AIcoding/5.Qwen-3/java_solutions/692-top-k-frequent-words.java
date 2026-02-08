public class Solution {

import java.util.*;

public class Solution {
    public List<String> topKFrequentWords(List<String> words, int k) {
        Map<String, Integer> frequencyMap = new HashMap<>();
        for (String word : words) {
            frequencyMap.put(word, frequencyMap.getOrDefault(word, 0) + 1);
        }

        PriorityQueue<Map.Entry<String, Integer>> maxHeap = new PriorityQueue<>(
            (a, b) -> a.getValue().equals(b.getValue()) ? b.getKey().compareTo(a.getKey()) : b.getValue() - a.getValue()
        );

        for (Map.Entry<String, Integer> entry : frequencyMap.entrySet()) {
            maxHeap.offer(entry);
        }

        List<String> result = new ArrayList<>();
        for (int i = 0; i < k; i++) {
            result.add(maxHeap.poll().getKey());
        }

        return result;
    }
}
}