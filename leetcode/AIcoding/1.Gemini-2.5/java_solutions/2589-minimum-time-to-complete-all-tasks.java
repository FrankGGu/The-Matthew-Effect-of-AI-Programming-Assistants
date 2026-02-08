import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int minTime(int[][] tasks) {
        Arrays.sort(tasks, new Comparator<int[]>() {
            @Override
            public int compare(int[] a, int[] b) {
                if (a[1] != b[1]) {
                    return a[1] - b[1];
                }
                return a[0] - b[0];
            }
        });

        boolean[] cpuOn = new boolean[2001];
        int totalTime = 0;

        for (int[] task : tasks) {
            int start = task[0];
            int end = task[1];
            int duration = task[2];

            int coveredDuration = 0;
            for (int t = start; t <= end; t++) {
                if (cpuOn[t]) {
                    coveredDuration++;
                }
            }

            int neededDuration = duration - coveredDuration;

            if (neededDuration > 0) {
                totalTime += neededDuration;
                for (int t = end; t >= start && neededDuration > 0; t--) {
                    if (!cpuOn[t]) {
                        cpuOn[t] = true;
                        neededDuration--;
                    }
                }
            }
        }

        return totalTime;
    }
}