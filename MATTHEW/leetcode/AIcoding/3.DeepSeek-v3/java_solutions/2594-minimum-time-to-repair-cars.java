class Solution {
    public long repairCars(int[] ranks, int cars) {
        long left = 1;
        long right = (long) ranks[0] * cars * cars;
        while (left < right) {
            long mid = left + (right - left) / 2;
            if (canRepairAll(ranks, cars, mid)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

    private boolean canRepairAll(int[] ranks, int cars, long time) {
        long total = 0;
        for (int rank : ranks) {
            total += (long) Math.sqrt(time / rank);
            if (total >= cars) {
                return true;
            }
        }
        return total >= cars;
    }
}