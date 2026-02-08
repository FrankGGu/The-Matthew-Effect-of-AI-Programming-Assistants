import java.util.HashMap;
import java.util.Map;
import java.util.PriorityQueue;

class Solution {
    public long taskSchedulerII(int[] tasks, int space) {
        Map<Integer, Long> lastExecuted = new HashMap<>();
        long days = 0;

        for (int task : tasks) {
            days++;
            if (lastExecuted.containsKey(task)) {
                long nextAvailableDay = lastExecuted.get(task) + space + 1;
                days = Math.max(days, nextAvailableDay);
            }
            lastExecuted.put(task, days);
        }
        return days;
    }
}