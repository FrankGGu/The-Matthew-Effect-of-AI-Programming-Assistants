class Solution {
    public boolean isComfortableHumidity(int[] humidity) {
        int n = humidity.length;
        if (n < 3) return false;

        Arrays.sort(humidity);

        for (int i = 1; i < n - 1; i++) {
            if (humidity[i] > humidity[i - 1] && humidity[i] < humidity[i + 1]) {
                return true;
            }
        }

        return false;
    }
}