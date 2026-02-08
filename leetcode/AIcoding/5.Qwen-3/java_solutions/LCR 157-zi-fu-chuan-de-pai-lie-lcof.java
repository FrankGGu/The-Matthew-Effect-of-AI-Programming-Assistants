public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> rearrangeBarcodes(int[] barcodes) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int code : barcodes) {
            count.put(code, count.getOrDefault(code, 0) + 1);
        }

        PriorityQueue<Map.Entry<Integer, Integer>> maxHeap = new PriorityQueue<>(
                (a, b) -> b.getValue() - a.getValue()
        );

        for (Map.Entry<Integer, Integer> entry : count.entrySet()) {
            maxHeap.offer(entry);
        }

        List<List<Integer>> result = new ArrayList<>();
        int index = 0;

        while (!maxHeap.isEmpty()) {
            Map.Entry<Integer, Integer> first = maxHeap.poll();
            int value = first.getKey();
            int freq = first.getValue();

            if (result.size() == 0 || result.get(result.size() - 1).get(0) != value) {
                result.add(new ArrayList<>());
                result.get(result.size() - 1).add(value);
                freq--;
            } else {
                result.get(result.size() - 1).add(value);
                freq--;
            }

            if (freq > 0) {
                maxHeap.offer(Map.entry(value, freq));
            }
        }

        return result;
    }
}
}