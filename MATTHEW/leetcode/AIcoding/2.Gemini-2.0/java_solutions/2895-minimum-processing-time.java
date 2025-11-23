import java.util.Arrays;

class Solution {
    public int minProcessingTime(List<Integer> processorTime, List<Integer> tasks) {
        Collections.sort(processorTime);
        Collections.sort(tasks, Collections.reverseOrder());

        int maxTime = 0;
        int taskIndex = 0;
        for (int i = 0; i < processorTime.size(); i++) {
            for (int j = 0; j < 4; j++) {
                maxTime = Math.max(maxTime, processorTime.get(i) + tasks.get(taskIndex));
                taskIndex++;
            }
        }

        return maxTime;
    }
}