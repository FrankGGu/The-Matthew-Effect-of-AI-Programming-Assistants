class Solution {
    public int temperatureTrend(int[] temperatureA, int[] temperatureB) {
        int n = temperatureA.length;
        int m = temperatureB.length;
        if (n <= 1 || m <= 1) {
            return 0;
        }
        int[] trendA = new int[n - 1];
        int[] trendB = new int[m - 1];
        for (int i = 0; i < n - 1; i++) {
            trendA[i] = Integer.compare(temperatureA[i + 1], temperatureA[i]);
        }
        for (int i = 0; i < m - 1; i++) {
            trendB[i] = Integer.compare(temperatureB[i + 1], temperatureB[i]);
        }
        int maxLen = 0;
        int currentLen = 0;
        for (int i = 0; i < Math.min(n - 1, m - 1); i++) {
            if (trendA[i] == trendB[i]) {
                currentLen++;
                maxLen = Math.max(maxLen, currentLen);
            } else {
                currentLen = 0;
            }
        }
        return maxLen;
    }
}