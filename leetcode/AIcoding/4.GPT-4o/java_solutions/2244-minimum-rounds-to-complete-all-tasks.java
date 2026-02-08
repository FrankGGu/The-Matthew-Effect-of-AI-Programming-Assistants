import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minimumRounds(int[] tasks) {
        Map<Integer, Integer> taskCount = new HashMap<>();
        for (int task : tasks) {
            taskCount.put(task, taskCount.getOrDefault(task, 0) + 1);
        }

        int rounds = 0;
        for (int count : taskCount.values()) {
            if (count == 1) return -1;
            rounds += (count + 2) / 3;
        }

        return rounds;
    }
}