class Solution {
    public int hardestWorker(int n, int[][] logs) {
        int maxDuration = 0;
        int resultEmployeeId = -1;
        int prevTime = 0;

        for (int[] log : logs) {
            int currentId = log[0];
            int currentTime = log[1];
            int currentDuration = currentTime - prevTime;

            if (currentDuration > maxDuration) {
                maxDuration = currentDuration;
                resultEmployeeId = currentId;
            } else if (currentDuration == maxDuration) {
                if (currentId < resultEmployeeId) {
                    resultEmployeeId = currentId;
                }
            }
            prevTime = currentTime;
        }

        return resultEmployeeId;
    }
}