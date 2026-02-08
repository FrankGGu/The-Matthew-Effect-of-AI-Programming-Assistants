class Solution {
    public int minSpeedOnTime(int[] dist, double hour) {
        int n = dist.length;

        // If the number of train rides (n) is greater than 1,
        // the first n-1 segments require waiting for the train after each segment.
        // This means each of the first n-1 segments will take at least 1 hour (due to Math.ceil()).
        // So, the minimum time for the first n-1 segments is n-1 hours.
        // The last segment takes dist[n-1] / speed, which is a positive value.
        // Therefore, the total time will always be strictly greater than n-1.
        // If 'hour' is less than or equal to n-1, it's impossible to arrive on time.
        // This check is not applicable for n=1, as there's no waiting time for the last segment.
        if (n > 1 && hour <= (double)(n - 1)) {
            return -1;
        }

        int low = 1;
        // The maximum possible speed.
        // If n > 1 and hour is very close to n-1 (e.g., n=2, dist=[1,1], hour=1.000000001),
        // the speed 's' might need to be as high as 10^9 to make the last segment's time very small.
        // (1 + 1/s <= 1.000000001 => 1/s <= 0.000000001 => s >= 10^9).
        // This value fits within an int.
        int high = 1_000_000_000; 
        int ans = -1;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (check(mid, dist, hour)) {
                ans = mid;
                high = mid - 1; // Try for a smaller speed
            } else {
                low = mid + 1; // Need a larger speed
            }
        }

        return ans;
    }

    // Helper function to check if a given speed allows arriving on time.
    private boolean check(int speed, int[] dist, double hour) {
        double totalTime = 0.0;
        // Calculate time for the first n-1 segments.
        // For each, time taken is ceil(distance / speed) due to waiting.
        for (int i = 0; i < dist.length - 1; i++) {
            totalTime += Math.ceil((double) dist[i] / speed);
        }
        // Calculate time for the last segment. No waiting time after the last segment.
        totalTime += (double) dist[dist.length - 1] / speed;

        // Check if the total time is within the allowed 'hour'.
        // Direct comparison for doubles is generally acceptable in LeetCode problems
        // unless extreme precision issues are specifically targeted.
        return totalTime <= hour;
    }
}