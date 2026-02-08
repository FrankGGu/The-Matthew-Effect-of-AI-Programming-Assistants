class Solution {
    public long maxPower(int[] stations, int r, int k) {
        int n = stations.length;
        long low = 0, high = 0;
        long[] sum = new long[n];
        sum[0] = stations[0];
        for (int i = 1; i < n; i++) {
            sum[i] = sum[i - 1] + stations[i];
        }

        for (int i = 0; i < n; i++) {
            high += stations[i];
        }

        while (low < high) {
            long mid = (low + high + 1) / 2;
            if (isPossible(stations, r, k, mid)) {
                low = mid;
            } else {
                high = mid - 1;
            }
        }
        return low;
    }

    private boolean isPossible(int[] stations, int r, int k, long target) {
        int n = stations.length;
        long[] add = new long[n];
        long currentSum = 0;
        long needed = 0;

        for (int i = 0; i < n; i++) {
            currentSum += (i > 0 ? add[i - 1] : 0);
            long currentPower = stations[i] + currentSum;

            if (currentPower < target) {
                long diff = target - currentPower;
                needed += diff;
                if (needed > k) {
                    return false;
                }
                currentSum += diff;
                if (i + 2 * r < n) {
                    add[i + 2 * r] -= diff;
                }
            }
        }
        return true;
    }
}