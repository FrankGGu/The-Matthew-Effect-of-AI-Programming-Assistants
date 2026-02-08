import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.PriorityQueue;

class Solution {
    public int leastInterval(char[] tasks, int n) {
        Map<Character, Integer> counts = new HashMap<>();
        for (char task : tasks) {
            counts.put(task, counts.getOrDefault(task, 0) + 1);
        }

        PriorityQueue<Integer> pq = new PriorityQueue<>((a, b) -> b - a);
        for (int count : counts.values()) {
            pq.offer(count);
        }

        int time = 0;
        while (!pq.isEmpty()) {
            int tempTime = 0;
            java.util.List<Integer> temp = new java.util.ArrayList<>();

            for (int i = 0; i <= n; i++) {
                if (!pq.isEmpty()) {
                    temp.add(pq.poll());
                    tempTime++;
                } else {
                    break;
                }
            }

            for (int count : temp) {
                if (count - 1 > 0) {
                    pq.offer(count - 1);
                }
            }

            if (pq.isEmpty()) {
                time += tempTime;
            } else {
                time += n + 1;
            }
        }

        return time;
    }
}