class Solution {
    public long maxPower(int[] stations, int r, int k) {
        int n = stations.length;
        long left = 0, right = k;
        for (int station : stations) {
            right += station;
        }
        long[] power = new long[n];
        while (left < right) {
            long mid = right - (right - left) / 2;
            if (canAchieve(stations, r, k, mid, power)) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }
        return left;
    }

    private boolean canAchieve(int[] stations, int r, int k, long minPower, long[] power) {
        int n = stations.length;
        Arrays.fill(power, 0);
        long sum = 0;
        long used = 0;
        for (int i = 0; i < n; i++) {
            if (i - r - 1 >= 0) {
                sum -= power[i - r - 1];
            }
            if (i + r < n) {
                sum += stations[i + r];
            }
            power[i] = stations[i] + sum;
            if (i > 0) {
                power[i] += power[i - 1];
                if (i - 2 * r - 1 >= 0) {
                    power[i] -= stations[i - 2 * r - 1];
                }
            }
        }
        sum = 0;
        for (int i = 0; i < n; i++) {
            if (i - r - 1 >= 0) {
                sum -= power[i - r - 1];
            }
            if (i + r < n) {
                sum += stations[i + r];
            }
            long current = stations[i] + sum;
            if (current < minPower) {
                long needed = minPower - current;
                if (needed > k - used) {
                    return false;
                }
                used += needed;
                if (i + r < n) {
                    power[i + r] += needed;
                }
                current = minPower;
            }
        }
        return true;
    }
}