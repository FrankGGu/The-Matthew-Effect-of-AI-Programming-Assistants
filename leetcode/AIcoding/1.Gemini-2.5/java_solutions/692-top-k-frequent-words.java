import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.PriorityQueue;
import java.util.ArrayList;
import java.util.Collections;

class Solution {
    public List<String> topKFrequent(String[] words, int k) {
        Map<String, Integer> freqMap = new HashMap<>();
        for (String word : words) {
            freqMap.put(word, freqMap.getOrDefault(word, 0) + 1);
        }

        PriorityQueue<String> pq = new PriorityQueue<>(
            (w1, w2) -> {
                int freq1 = freqMap.get(w1);
                int freq2 = freqMap.get(w2);
                if (freq1 != freq2) {
                    return freq1 - freq2; // Sort by frequency in ascending order
                } else {
                    return w2.compareTo(w1); // Sort by word in descending alphabetical order
                }
            }
        );

        for (String word : freqMap.keySet()) {
            pq.offer(word);
            if (pq.size() > k) {
                pq.poll();
            }
        }

        List<String> result = new ArrayList<>();
        while (!pq.isEmpty()) {
            result.add(pq.poll());
        }

        Collections.reverse(result);
        return result;
    }
}