class Solution {
    public int temperatureTrend(int[] temperatureA, int[] temperatureB) {
        int n = temperatureA.length;
        int maxLen = 0;
        int currentLen = 0;

        for (int i = 1; i < n; i++) {
            int trendA = Integer.compare(temperatureA[i], temperatureA[i - 1]);
            int trendB = Integer.compare(temperatureB[i], temperatureB[i - 1]);

            if (trendA == trendB) {
                currentLen++;
                maxLen = Math.max(maxLen, currentLen);
            } else {
                currentLen = 0;
            }
        }

        return maxLen;
    }
}