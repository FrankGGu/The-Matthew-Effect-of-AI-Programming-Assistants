class Solution {
public:
    long long sumOfPrices(long long n, int x) {
        long long res = 0;
        for (long long i = 1; i <= n; ++i) {
            long long num = i;
            int cnt = 0;
            while (num % x == 0) {
                num /= x;
                cnt++;
            }
            res += cnt;
        }
        return res;
    }

    long long findMaximumNumber(long long k, int x) {
        long long left = 1, right = 1e15;
        long long ans = 0;
        while (left <= right) {
            long long mid = left + (right - left) / 2;
            long long sum = sumOfPrices(mid, x);
            if (sum <= k) {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return ans;
    }
};