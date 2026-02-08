class Solution {
    public long maxTheNumber(long k) {
        long low = 0;
        long high = k;
        long ans = 0;

        while (low <= high) {
            long mid = low + (high - low) / 2;
            if (calculateSum(mid) <= k) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return ans;
    }

    private long calculateSum(long x) {
        if (x == 0) {
            return 0;
        }
        long totalSum = x;
        long currentPowerOf2 = 2;
        while (currentPowerOf2 <= x) {
            totalSum += currentPowerOf2 * (x / currentPowerOf2);
            currentPowerOf2 *= 2;
        }
        return totalSum;
    }
}