class Solution {
    public int minimumFinishTime(int[][] tires, int changeTime, int numLaps) {
        int[] minTime = new int[numLaps + 1];
        Arrays.fill(minTime, Integer.MAX_VALUE);

        for (int[] tire : tires) {
            int f = tire[0];
            int r = tire[1];
            int total = 0;
            for (int lap = 1; lap <= numLaps; lap++) {
                int currentLapTime = f * (int) Math.pow(r, lap - 1);
                if (currentLapTime > changeTime + f) {
                    break;
                }
                total += currentLapTime;
                if (total < minTime[lap]) {
                    minTime[lap] = total;
                }
            }
        }

        int[] dp = new int[numLaps + 1];
        for (int lap = 1; lap <= numLaps; lap++) {
            dp[lap] = minTime[lap] != Integer.MAX_VALUE ? minTime[lap] : Integer.MAX_VALUE;
            for (int prevLap = 1; prevLap < lap; prevLap++) {
                if (minTime[prevLap] != Integer.MAX_VALUE && dp[lap - prevLap] != Integer.MAX_VALUE) {
                    int candidate = minTime[prevLap] + changeTime + dp[lap - prevLap];
                    if (candidate < dp[lap]) {
                        dp[lap] = candidate;
                    }
                }
            }
        }

        return dp[numLaps];
    }
}