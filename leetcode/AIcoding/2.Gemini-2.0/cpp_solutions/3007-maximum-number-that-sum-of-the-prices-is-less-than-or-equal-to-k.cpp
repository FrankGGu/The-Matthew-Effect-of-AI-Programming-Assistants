class Solution {
public:
    long long sumOfPrices(long long n) {
        long long ans = 0;
        long long p = 1;
        while (p <= n) {
            ans += n - p + 1;
            p *= 2;
        }
        return ans;
    }

    long long findMaximumNumber(long long k) {
        long long low = 0, high = 1e18;
        long long ans = 0;
        while (low <= high) {
            long long mid = low + (high - low) / 2;
            if (sumOfPrices(mid) <= k) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return ans;
    }
};