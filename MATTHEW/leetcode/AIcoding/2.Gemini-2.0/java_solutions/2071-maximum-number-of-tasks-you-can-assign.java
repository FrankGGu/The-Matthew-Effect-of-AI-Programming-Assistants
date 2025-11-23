import java.util.Arrays;

class Solution {
    public int maxTasks(int[] tasks, int[] workers, int pills, int strength) {
        Arrays.sort(tasks);
        Arrays.sort(workers);
        int left = 0, right = Math.min(tasks.length, workers.length);
        int ans = 0;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canAssign(tasks, workers, pills, strength, mid)) {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return ans;
    }

    private boolean canAssign(int[] tasks, int[] workers, int pills, int strength, int mid) {
        int[] workerCopy = Arrays.copyOfRange(workers, workers.length - mid, workers.length);
        int[] taskCopy = Arrays.copyOfRange(tasks, 0, mid);
        Arrays.sort(workerCopy);
        int i = mid - 1, j = mid - 1;
        while (i >= 0) {
            if (workerCopy[j] >= taskCopy[i]) {
                j--;
                i--;
            } else {
                if (pills > 0 && workerCopy[j] + strength >= taskCopy[i]) {
                    pills--;
                    i--;
                } else {
                    return false;
                }
            }
        }
        return true;
    }
}