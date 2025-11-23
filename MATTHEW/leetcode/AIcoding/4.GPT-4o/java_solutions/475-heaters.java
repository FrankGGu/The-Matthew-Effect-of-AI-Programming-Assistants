import java.util.Arrays;

public class Solution {
    public int findRadius(int[] houses, int[] heaters) {
        Arrays.sort(heaters);
        int radius = 0;

        for (int house : houses) {
            int pos = Arrays.binarySearch(heaters, house);
            if (pos < 0) {
                pos = -(pos + 1);
            }
            int leftDist = pos > 0 ? house - heaters[pos - 1] : Integer.MAX_VALUE;
            int rightDist = pos < heaters.length ? heaters[pos] - house : Integer.MAX_VALUE;
            radius = Math.max(radius, Math.min(leftDist, rightDist));
        }

        return radius;
    }
}