class Solution {
    public int temperatureTrend(int[] temperatureA, int[] temperatureB) {
        int n = temperatureA.length;
        if (n <= 1) {
            return 0;
        }

        int maxConsecutive = 0;
        int currentConsecutive = 0;

        for (int i = 1; i < n; i++) {
            int trendA = 0;
            if (temperatureA[i] > temperatureA[i - 1]) {
                trendA = 1;
            } else if (temperatureA[i] < temperatureA[i - 1]) {
                trendA = -1;
            }

            int trendB = 0;
            if (temperatureB[i] > temperatureB[i - 1]) {
                trendB = 1;
            } else if (temperatureB[i] < temperatureB[i - 1]) {
                trendB = -1;
            }

            if (trendA == trendB) {
                currentConsecutive++;
            } else {
                currentConsecutive = 0;
            }
            maxConsecutive = Math.max(maxConsecutive, currentConsecutive);
        }

        return maxConsecutive;
    }
}