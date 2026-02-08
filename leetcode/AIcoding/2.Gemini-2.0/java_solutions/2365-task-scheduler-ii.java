import java.util.HashMap;
import java.util.Map;

class Solution {
    public long taskSchedulerII(int[] tasks, int space) {
        Map<Integer, Long> lastCompletion = new HashMap<>();
        long day = 0;
        for (int task : tasks) {
            day++;
            if (lastCompletion.containsKey(task)) {
                long lastDay = lastCompletion.get(task);
                long diff = day - lastDay - 1;
                if (diff < space) {
                    day += (space - diff);
                }
            }
            lastCompletion.put(task, day);
        }
        return day;
    }
}