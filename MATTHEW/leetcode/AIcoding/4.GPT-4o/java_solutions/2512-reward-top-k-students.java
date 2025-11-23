import java.util.*;

class Solution {
    public List<Integer> topKStudents(int[][] score, int k) {
        Map<Integer, Integer> studentScoreMap = new HashMap<>();
        for (int[] s : score) {
            studentScoreMap.put(s[0], studentScoreMap.getOrDefault(s[0], 0) + s[1]);
        }

        PriorityQueue<Map.Entry<Integer, Integer>> minHeap = new PriorityQueue<>(
            (a, b) -> a.getValue().equals(b.getValue()) ? a.getKey() - b.getKey() : a.getValue() - b.getValue()
        );

        for (Map.Entry<Integer, Integer> entry : studentScoreMap.entrySet()) {
            minHeap.offer(entry);
            if (minHeap.size() > k) {
                minHeap.poll();
            }
        }

        List<Integer> result = new ArrayList<>();
        while (!minHeap.isEmpty()) {
            result.add(minHeap.poll().getKey());
        }

        Collections.sort(result);
        return result;
    }
}