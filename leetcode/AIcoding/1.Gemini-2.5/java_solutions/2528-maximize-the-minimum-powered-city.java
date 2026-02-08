class Solution {
    public long maxPower(int[] stations, int r, int k) {
        int n = stations.length;

        long low = 0;
        // Maximum possible power: sum of all initial stations + k additional stations.
        // Max initial stations sum: 2e5 * 1e5 = 2e10. Max k: 1e9.
        // So a rough upper bound is 2e10 + 1e9, which fits in long.
        long high = 2_000_000_000_000L; // A sufficiently large upper bound
        long ans = 0;

        while (low <= high) {
            long mid = low + (high - low) / 2;
            if (check(mid, n, r, k, stations)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return ans;
    }

    private boolean check(long targetMinPower, int n, int r, long k, int[] stations) {
        // current_stations_count[i] will store stations[i] + any additional stations we decide to add at city i.
        // This array is modified during the check.
        long[] currentStationsCount = new long[n];
        for (int i = 0; i < n; i++) {
            currentStationsCount[i] = stations[i];
        }

        long totalKUsed = 0;
        long currentPowerFromWindow = 0; // This is the sum of currentStationsCount[j] for j in [max(0, i-r), min(n-1, i+r)]

        // Initialize currentPowerFromWindow for city 0
        for (int j = 0; j <= Math.min(n - 1, r); j++) {
            currentPowerFromWindow += currentStationsCount[j];
        }

        for (int i = 0; i < n; i++) {
            // currentPowerFromWindow now holds the total power for city i.
            if (currentPowerFromWindow < targetMinPower) {
                long needed = targetMinPower - currentPowerFromWindow;
                totalKUsed += needed;

                if (totalKUsed > k) {
                    return false; // Not enough k to meet the target
                }

                // Add `needed` stations at the rightmost possible position to help city `i`.
                // This position is `i + r`. Adding a station at `i + r` helps cities in `[i, i + 2*r]`.
                // This greedy choice maximizes the reach of the added stations to the right.
                int stationPlacementIdx = Math.min(n - 1, i + r);
                currentStationsCount[stationPlacementIdx] += needed;

                // Since we added stations at `stationPlacementIdx`, and `stationPlacementIdx` is always within
                // the current window `[max(0, i-r), min(n-1, i+r)]`, we update the window sum.
                currentPowerFromWindow += needed;
            }

            // Prepare currentPowerFromWindow for the next city (i+1)
            // Remove the contribution from the leftmost station that falls out of the window for (i+1).
            // This is currentStationsCount[i-r].
            if (i - r >= 0) {
                currentPowerFromWindow -= currentStationsCount[i - r];
            }
            // Add the contribution from the rightmost station that enters the window for (i+1).
            // This is currentStationsCount[i+r+1].
            if (i + r + 1 < n) {
                currentPowerFromWindow += currentStationsCount[i + r + 1];
            }
        }

        return true; // All cities can achieve at least targetMinPower
    }
}