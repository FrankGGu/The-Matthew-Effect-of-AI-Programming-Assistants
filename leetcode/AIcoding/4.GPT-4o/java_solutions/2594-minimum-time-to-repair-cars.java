import java.util.PriorityQueue;

public class Solution {
    public long repairCars(int[] ranks, int cars) {
        long left = 1, right = (long) 1e14;
        while (left < right) {
            long mid = left + (right - left) / 2;
            if (canRepair(ranks, mid, cars)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

    private boolean canRepair(int[] ranks, long time, int cars) {
        long totalCars = 0;
        for (int rank : ranks) {
            totalCars += Math.sqrt(time / rank);
            if (totalCars >= cars) {
                return true;
            }
        }
        return totalCars >= cars;
    }
}