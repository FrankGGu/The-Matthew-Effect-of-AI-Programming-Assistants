class Solution {
    public int mergeOperations(int[] travel, int k) {
        int n = travel.length;

        long low = 0; // Minimum possible maximum travel time (largest single element)
        long high = 0; // Maximum possible maximum travel time (sum of all elements)
        for (int t : travel) {
            low = Math.max(low, t);
            high += t;
        }

        long ans = high; // Initialize ans with the maximum possible value

        // Binary search for the minimum possible maximum travel time
        while (low <= high) {
            long mid = low + (high - low) / 2;
            if (check(mid, travel, k)) {
                // If 'mid' is a possible maximum travel time, try to find a smaller one
                ans = mid;
                high = mid - 1;
            } else {
                // If 'mid' is not possible, we need a larger maximum travel time
                low = mid + 1;
            }
        }
        return (int) ans;
    }

    private boolean check(long maxTravelTime, int[] travel, int k) {
        int n = travel.length;
        long currentSum = 0;
        int segments = 1; // Start with one segment

        for (int t : travel) {
            // If any individual element is greater than maxTravelTime, it's impossible.
            if (t > maxTravelTime) {
                return false;
            }

            if (currentSum + t <= maxTravelTime) {
                currentSum += t;
            } else {
                // Current segment sum exceeds maxTravelTime, start a new segment.
                segments++;
                currentSum = t;
            }
        }

        // We need to achieve at least 'n - k' segments.
        // If the minimum number of segments we can form ('segments') is less than or equal to 'n - k',
        // it means we can achieve 'maxTravelTime' while having at least 'n - k' segments.
        // (We can always split segments further if 'segments < n - k' to reach exactly 'n - k' segments).
        return segments <= n - k;
    }
}