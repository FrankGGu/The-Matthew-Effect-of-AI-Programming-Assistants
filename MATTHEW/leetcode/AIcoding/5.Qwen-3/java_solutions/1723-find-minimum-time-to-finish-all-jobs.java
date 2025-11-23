public class Solution {

import java.util.*;

public class Solution {
    public int minimumTimeRequired(int[] jobs, int k) {
        Arrays.sort(jobs);
        reverseArray(jobs);
        int[] worker = new int[k];
        return dfs(jobs, 0, worker, 0);
    }

    private int dfs(int[] jobs, int index, int[] worker, int max) {
        if (index == jobs.length) {
            return max;
        }
        int minTime = Integer.MAX_VALUE;
        Set<Integer> used = new HashSet<>();
        for (int i = 0; i < worker.length; i++) {
            if (worker[i] == 0 || !used.contains(worker[i])) {
                used.add(worker[i]);
                worker[i] += jobs[index];
                minTime = Math.min(minTime, dfs(jobs, index + 1, worker, Math.max(max, worker[i])));
                worker[i] -= jobs[index];
            }
        }
        return minTime;
    }

    private void reverseArray(int[] array) {
        int left = 0, right = array.length - 1;
        while (left < right) {
            int temp = array[left];
            array[left] = array[right];
            array[right] = temp;
            left++;
            right--;
        }
    }
}
}