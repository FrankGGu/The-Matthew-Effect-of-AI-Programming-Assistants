public class Solution {

import java.util.Arrays;

public class Solution {
    public int minProcessingTime(int[] processorTime, int[] tasks) {
        Arrays.sort(tasks);
        Arrays.sort(processorTime);
        int max = 0;
        for (int i = 0; i < tasks.length; i++) {
            int time = processorTime[i / 4] + tasks[i];
            if (time > max) {
                max = time;
            }
        }
        return max;
    }
}
}