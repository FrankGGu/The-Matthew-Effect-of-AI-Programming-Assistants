public class Solution {

import java.util.*;

public class Solution {
    public int maxTasksYouCanAssign(int[] skills, int[] tasks) {
        int n = skills.length;
        int m = tasks.length;
        Arrays.sort(skills);
        int[][] taskList = new int[m][2];
        for (int i = 0; i < m; i++) {
            taskList[i][0] = tasks[i];
            taskList[i][1] = i;
        }
        Arrays.sort(taskList, (a, b) -> a[0] - b[0]);
        int left = 0, right = m;
        int result = 0;
        while (left <= right) {
            int mid = (left + right) / 2;
            if (canAssign(mid, skills, taskList)) {
                result = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return result;
    }

    private boolean canAssign(int k, int[] skills, int[][] taskList) {
        int[] sortedSkills = Arrays.copyOf(skills, skills.length);
        Arrays.sort(sortedSkills);
        int[] sortedTasks = new int[k];
        for (int i = 0; i < k; i++) {
            sortedTasks[i] = taskList[i][0];
        }
        Arrays.sort(sortedTasks);
        int i = 0, j = 0;
        while (i < k && j < sortedSkills.length) {
            if (sortedTasks[i] <= sortedSkills[j]) {
                i++;
            }
            j++;
        }
        return i == k;
    }
}
}