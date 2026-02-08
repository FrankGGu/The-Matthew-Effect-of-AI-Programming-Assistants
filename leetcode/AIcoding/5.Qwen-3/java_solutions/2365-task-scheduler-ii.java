public class Solution {

import java.util.*;

public class Solution {
    public int leastInterval(char[] tasks, int n) {
        if (n == 0) {
            return tasks.length;
        }

        Map<Character, Integer> taskCount = new HashMap<>();
        for (char task : tasks) {
            taskCount.put(task, taskCount.getOrDefault(task, 0) + 1);
        }

        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());
        for (int count : taskCount.values()) {
            maxHeap.add(count);
        }

        int time = 0;

        while (!maxHeap.isEmpty()) {
            int i = 0;
            List<Integer> temp = new ArrayList<>();
            while (i <= n && !maxHeap.isEmpty()) {
                int current = maxHeap.poll();
                if (current > 1) {
                    temp.add(current - 1);
                }
                i++;
                time++;
            }

            for (int val : temp) {
                maxHeap.add(val);
            }
        }

        return time;
    }
}
}