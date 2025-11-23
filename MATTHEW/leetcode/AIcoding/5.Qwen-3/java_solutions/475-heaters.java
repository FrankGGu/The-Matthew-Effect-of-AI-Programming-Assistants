public class Solution {

import java.util.Arrays;

public class Solution {
    public int findRadius(int[] houses, int[] heaters) {
        Arrays.sort(heaters);
        int result = 0;
        for (int house : houses) {
            int left = 0;
            int right = heaters.length - 1;
            while (left < right) {
                int mid = left + (right - left) / 2;
                if (heaters[mid] < house) {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
            int distance = Math.abs(heaters[left] - house);
            result = Math.max(result, distance);
        }
        return result;
    }
}
}