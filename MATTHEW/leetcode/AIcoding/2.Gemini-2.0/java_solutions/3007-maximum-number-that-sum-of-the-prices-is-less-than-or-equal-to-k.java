class Solution {
    public long maximumNumber(long k, int x) {
        long low = 0, high = k;
        long ans = 0;
        while (low <= high) {
            long mid = low + (high - low) / 2;
            long priceSum = calculatePriceSum(mid, x);
            if (priceSum <= k) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return ans;
    }

    private long calculatePriceSum(long n, int x) {
        long sum = n;
        long powerOfX = x;
        while (powerOfX <= n) {
            sum -= n / powerOfX;
            if (powerOfX > n / x) break;
            powerOfX *= x;
        }
        return sum;
    }
}