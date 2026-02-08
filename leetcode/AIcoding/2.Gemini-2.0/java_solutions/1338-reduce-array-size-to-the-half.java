import java.util.HashMap;
import java.util.PriorityQueue;
import java.util.Map;

class Solution {
    public int minSetSize(int[] arr) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : arr) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        PriorityQueue<Integer> pq = new PriorityQueue<>((a, b) -> b - a);
        for (int freq : count.values()) {
            pq.offer(freq);
        }

        int removed = 0;
        int steps = 0;
        int half = arr.length / 2;

        while (removed < half) {
            removed += pq.poll();
            steps++;
        }

        return steps;
    }
}