class Solution {
    public long minimumTime(int[] ranks, int cars) {
        long low = 1;
        long high = 1L * ranks[0] * cars * cars; // Max possible time for a single mechanic to repair all cars
        long ans = high;

        while (low <= high) {
            long mid = low + (high - low) / 2;
            if (canRepair(mid, ranks, cars)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    }

    private boolean canRepair(long time, int[] ranks, int cars) {
        long carsRepaired = 0;
        for (int rank : ranks) {
            // A mechanic with rank 'r' can repair 'k' cars in r * k * k time.
            // If total time is 'T', then r * k * k <= T
            // k * k <= T / r
            // k <= sqrt(T / r)
            carsRepaired += (long) Math.sqrt(time / rank);
            if (carsRepaired >= cars) {
                return true;
            }
        }
        return carsRepaired >= cars;
    }
}