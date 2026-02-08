class Solution {
    public int hardestWorker(int n, int[][] logs) {
        int maxTime = 0;
        int hardestWorkerId = 0;
        int prevTime = 0;

        for (int[] log : logs) {
            int id = log[0];
            int time = log[1] - prevTime;
            prevTime = log[1];

            if (time > maxTime || (time == maxTime && id > hardestWorkerId)) {
                maxTime = time;
                hardestWorkerId = id;
            }
        }

        return hardestWorkerId;
    }
}