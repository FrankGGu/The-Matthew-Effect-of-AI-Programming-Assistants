import java.util.TreeMap;

class Solution {
    public int comfortableHumidity(int[] humidityReadings, int limit) {
        if (humidityReadings == null || humidityReadings.length == 0) {
            return 0;
        }

        TreeMap<Integer, Integer> window = new TreeMap<>();
        int left = 0;
        int maxLength = 0;

        for (int right = 0; right < humidityReadings.length; right++) {
            window.put(humidityReadings[right], window.getOrDefault(humidityReadings[right], 0) + 1);

            while (window.lastKey() - window.firstKey() > limit) {
                int leftVal = humidityReadings[left];
                window.put(leftVal, window.get(leftVal) - 1);
                if (window.get(leftVal) == 0) {
                    window.remove(leftVal);
                }
                left++;
            }

            maxLength = Math.max(maxLength, right - left + 1);
        }

        return maxLength;
    }
}