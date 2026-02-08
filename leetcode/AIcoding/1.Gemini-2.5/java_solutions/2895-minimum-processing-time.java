import java.util.Collections;
import java.util.List;
import java.util.ArrayList;

class Solution {
    public long minProcessingTime(List<Integer> processorTime, List<Integer> tasks) {
        Collections.sort(processorTime);
        Collections.sort(tasks, Collections.reverseOrder());

        long minMaxTime = 0;
        int n = processorTime.size();

        for (int i = 0; i < n; i++) {
            long currentProcessorAvailableTime = processorTime.get(i);
            long longestTaskForThisProcessor = tasks.get(i * 4);
            minMaxTime = Math.max(minMaxTime, currentProcessorAvailableTime + longestTaskForThisProcessor);
        }

        return minMaxTime;
    }
}