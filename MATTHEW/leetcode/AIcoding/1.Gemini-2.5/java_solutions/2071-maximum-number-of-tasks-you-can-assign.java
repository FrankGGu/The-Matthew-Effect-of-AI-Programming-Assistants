import java.util.Arrays;
import java.util.TreeSet;

class Solution {
    public int maximumTasks(int[] tasks, int[] workers, int pills, int strength) {
        Arrays.sort(tasks);
        Arrays.sort(workers);

        int n = tasks.length;
        int m = workers.length;

        int low = 0;
        int high = Math.min(n, m);
        int ans = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (check(mid, tasks, workers, pills, strength)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return ans;
    }

    private boolean check(int k, int[] tasks, int[] workers, int pills, int strength) {
        if (k == 0) {
            return true;
        }

        int currentPills = pills;
        int taskPointer = 0; 
        TreeSet<Integer> availableTasks = new TreeSet<>(); 

        for (int i = workers.length - k; i < workers.length; i++) {
            int currentWorkerStrength = workers[i];

            while (taskPointer < k && tasks[taskPointer] <= currentWorkerStrength + strength) {
                availableTasks.add(tasks[taskPointer]);
                taskPointer++;
            }

            Integer taskWithoutPill = availableTasks.floor(currentWorkerStrength);
            if (taskWithoutPill != null) {
                availableTasks.remove(taskWithoutPill);
            } else {
                if (currentPills > 0 && !availableTasks.isEmpty()) {
                    Integer taskWithPill = availableTasks.last();
                    availableTasks.remove(taskWithPill);
                    currentPills--;
                } else {
                    return false;
                }
            }
        }

        return true; 
    }
}