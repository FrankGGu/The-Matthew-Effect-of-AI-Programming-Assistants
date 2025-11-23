import java.util.Arrays;

class Solution {
    public int findMinimumTime(int[][] tasks) {
        Arrays.sort(tasks, (a, b) -> a[1] - b[1]);
        int n = tasks.length;
        int maxEndTime = 0;
        for (int[] task : tasks) {
            maxEndTime = Math.max(maxEndTime, task[1]);
        }
        boolean[] timeTaken = new boolean[maxEndTime + 1];
        int count = 0;

        for (int[] task : tasks) {
            int start = task[0];
            int end = task[1];
            int duration = task[2];

            int taken = 0;
            for (int i = start; i <= end; i++) {
                if (timeTaken[i]) {
                    taken++;
                }
            }

            if (taken >= duration) {
                continue;
            }

            for (int i = end; i >= start && taken < duration; i--) {
                if (!timeTaken[i]) {
                    timeTaken[i] = true;
                    count++;
                    taken++;
                }
            }
        }

        return count;
    }
}