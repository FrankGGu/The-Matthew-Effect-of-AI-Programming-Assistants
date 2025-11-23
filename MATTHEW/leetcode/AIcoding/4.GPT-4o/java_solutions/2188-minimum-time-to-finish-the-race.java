class Solution {
    public double minimumFinishTime(int[][] tires, int changeTime, int numLaps) {
        long[] dp = new long[numLaps + 1];
        double[] minTime = new double[numLaps + 1];
        for (int i = 1; i <= numLaps; i++) {
            dp[i] = Long.MAX_VALUE;
            minTime[i] = Double.MAX_VALUE;
            for (int[] tire : tires) {
                long time = tire[0];
                long totalTime = time;
                for (int j = 1; j <= i; j++) {
                    if (totalTime >= Long.MAX_VALUE) break;
                    dp[j] = Math.min(dp[j], totalTime);
                    if (j < i) totalTime += time * (1L << j);
                }
            }
            for (int j = 1; j <= i; j++) {
                minTime[i] = Math.min(minTime[i], dp[j] + (j < i ? changeTime : 0) + minTime[i - j]);
            }
        }
        return minTime[numLaps];
    }
}