class Solution {
    public int hardestWorker(int n, int[][] logs) {
        int maxTime = logs[0][1];
        int employeeId = logs[0][0];
        for (int i = 1; i < logs.length; i++) {
            int time = logs[i][1] - logs[i - 1][1];
            if (time > maxTime) {
                maxTime = time;
                employeeId = logs[i][0];
            } else if (time == maxTime) {
                employeeId = Math.min(employeeId, logs[i][0]);
            }
        }
        return employeeId;
    }
}