public class Solution {

import java.util.Arrays;

public class Solution {
    public long repairCars(int[] costs, int t) {
        long left = 0;
        long right = (long) Arrays.stream(costs).min().getAsInt() * t;

        while (left < right) {
            long mid = (left + right) / 2;
            long total = 0;
            for (int cost : costs) {
                total += mid / cost;
                if (total >= t) break;
            }
            if (total >= t) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }
}
}