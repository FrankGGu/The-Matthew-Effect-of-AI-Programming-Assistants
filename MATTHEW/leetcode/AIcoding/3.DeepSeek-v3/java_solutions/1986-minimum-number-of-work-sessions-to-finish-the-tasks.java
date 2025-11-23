class Solution {
    private int minSessions = Integer.MAX_VALUE;

    public int minSessions(int[] tasks, int sessionTime) {
        Arrays.sort(tasks);
        reverse(tasks);
        backtrack(tasks, sessionTime, 0, new int[tasks.length], 0);
        return minSessions;
    }

    private void backtrack(int[] tasks, int sessionTime, int index, int[] sessions, int sessionCount) {
        if (sessionCount >= minSessions) {
            return;
        }
        if (index == tasks.length) {
            minSessions = sessionCount;
            return;
        }
        for (int i = 0; i < sessionCount; i++) {
            if (sessions[i] + tasks[index] <= sessionTime) {
                sessions[i] += tasks[index];
                backtrack(tasks, sessionTime, index + 1, sessions, sessionCount);
                sessions[i] -= tasks[index];
            }
        }
        sessions[sessionCount] = tasks[index];
        backtrack(tasks, sessionTime, index + 1, sessions, sessionCount + 1);
        sessions[sessionCount] = 0;
    }

    private void reverse(int[] arr) {
        int left = 0, right = arr.length - 1;
        while (left < right) {
            int temp = arr[left];
            arr[left] = arr[right];
            arr[right] = temp;
            left++;
            right--;
        }
    }
}