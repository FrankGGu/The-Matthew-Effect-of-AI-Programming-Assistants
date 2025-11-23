class Solution {
    public long repairCars(int[] ranks, int cars) {
        long low = 0;
        long high = (long) ranks[0] * (long) cars * (long) cars;
        for (int rank : ranks) {
            high = Math.max(high, (long) rank * (long) cars * (long) cars);
        }

        long ans = high;

        while (low <= high) {
            long mid = low + (high - low) / 2;
            long repairedCars = 0;
            for (int rank : ranks) {
                repairedCars += (long) Math.sqrt((double) mid / rank);
            }

            if (repairedCars >= cars) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        return ans;
    }
}