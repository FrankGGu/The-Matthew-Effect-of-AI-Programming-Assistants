import java.util.Arrays;

class Solution {
    public int minMaxTime(int[] tasks, int k) {
        if (tasks == null || tasks.length == 0) {
            return 0;
        }

        int low = 0;
        int high = 0;
        for (int taskTime : tasks) {
            high += taskTime;
            low = Math.max(low, taskTime);
        }

        int ans = high;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (check(mid, tasks, k)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    }

    private boolean check(int maxAllowedTime, int[] tasks, int k) {
        int workersNeeded = 1;
        int currentWorkerTime = 0;
        for (int taskTime : tasks) {
            if (taskTime > maxAllowedTime) {
                return false;
            }
            if (currentWorkerTime + taskTime <= maxAllowedTime) {
                currentWorkerTime += taskTime;
            } else {
                workersNeeded++;
                currentWorkerTime = taskTime;
            }
        }
        return workersNeeded <= k;
    }
}