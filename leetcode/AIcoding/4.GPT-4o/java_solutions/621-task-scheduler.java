import java.util.HashMap;
import java.util.Map;
import java.util.PriorityQueue;

public class Solution {
    public int leastInterval(char[] tasks, int n) {
        Map<Character, Integer> taskCount = new HashMap<>();
        for (char task : tasks) {
            taskCount.put(task, taskCount.getOrDefault(task, 0) + 1);
        }

        PriorityQueue<Integer> maxHeap = new PriorityQueue<>((a, b) -> b - a);
        maxHeap.addAll(taskCount.values());

        int intervals = 0;
        while (!maxHeap.isEmpty()) {
            int time = 0;
            List<Integer> waitList = new ArrayList<>();
            for (int i = 0; i <= n; i++) {
                if (!maxHeap.isEmpty()) {
                    waitList.add(maxHeap.poll());
                    time++;
                }
                if (maxHeap.isEmpty() && i < n) break;
            }
            for (int count : waitList) {
                if (--count > 0) {
                    maxHeap.add(count);
                }
            }
            intervals += maxHeap.isEmpty() ? time : n + 1;
        }
        return intervals;
    }
}