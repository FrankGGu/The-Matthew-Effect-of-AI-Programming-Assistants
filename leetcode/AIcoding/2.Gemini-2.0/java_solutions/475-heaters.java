import java.util.Arrays;

class Solution {
    public int findRadius(int[] houses, int[] heaters) {
        Arrays.sort(houses);
        Arrays.sort(heaters);
        int radius = 0;
        for (int house : houses) {
            int left = 0;
            int right = heaters.length - 1;
            int minDistance = Integer.MAX_VALUE;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                minDistance = Math.min(minDistance, Math.abs(heaters[mid] - house));
                if (heaters[mid] < house) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
            if (right >= 0) {
                minDistance = Math.min(minDistance, Math.abs(heaters[right] - house));
            }
            if (left < heaters.length) {
                minDistance = Math.min(minDistance, Math.abs(heaters[left] - house));
            }
            radius = Math.max(radius, minDistance);
        }
        return radius;
    }
}