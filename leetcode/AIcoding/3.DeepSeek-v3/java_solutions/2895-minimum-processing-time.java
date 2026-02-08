import java.util.Arrays;

class Solution {
    public int minProcessingTime(List<Integer> processorTime, List<Integer> tasks) {
        Collections.sort(processorTime);
        Collections.sort(tasks, Collections.reverseOrder());

        int maxTime = 0;
        for (int i = 0; i < processorTime.size(); i++) {
            int currentMax = processorTime.get(i) + tasks.get(i * 4);
            if (currentMax > maxTime) {
                maxTime = currentMax;
            }
        }
        return maxTime;
    }
}