import java.util.HashMap;
import java.util.Map;

class Solution {
    public long taskSchedulerII(int[] tasks, int space) {
        Map<Integer, Long> lastExecutionDay = new HashMap<>();
        long currentTime = 0;

        for (int task : tasks) {
            if (lastExecutionDay.containsKey(task)) {
                long prevExecutionDay = lastExecutionDay.get(task);
                long nextAvailableDay = prevExecutionDay + space + 1;
                currentTime = Math.max(currentTime + 1, nextAvailableDay);
            } else {
                currentTime = currentTime + 1;
            }
            lastExecutionDay.put(task, currentTime);
        }

        return currentTime;
    }
}