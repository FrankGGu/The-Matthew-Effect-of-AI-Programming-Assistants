class Solution {
    public int minimumFinishTime(int[][] tires, int changeTime, int numLaps) {
        int maxLaps = Math.min(numLaps, 17);
        int[] bestTime = new int[maxLaps + 1];
        Arrays.fill(bestTime, Integer.MAX_VALUE);
        bestTime[0] = 0;

        for (int[] tire : tires) {
            int f = tire[0];
            int r = tire[1];
            int currentTime = 0;
            int totalTime = 0;
            for (int laps = 1; laps <= maxLaps; laps++) {
                currentTime = f * (int) Math.pow(r, laps - 1);
                totalTime += currentTime;
                if (totalTime > changeTime + f) break;
                bestTime[laps] = Math.min(bestTime[laps], totalTime);
            }
        }

        int[] dp = new int[numLaps + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int i = 1; i <= numLaps; i++) {
            for (int j = 1; j <= Math.min(i, maxLaps); j++) {
                if (bestTime[j] == Integer.MAX_VALUE || dp[i - j] == Integer.MAX_VALUE) continue;
                dp[i] = Math.min(dp[i], dp[i - j] + bestTime[j] + changeTime);
            }
        }

        return dp[numLaps] - changeTime;
    }
}