class Solution {
public:
    int numOfWays(vector<int>& nums) {
        int n = nums.size();
        const int MOD = 1e9 + 7;

        function<long long(int, int)> comb = [&](int n, int k) {
            long long res = 1;
            for (int i = 0; i < k; i++) {
                res = res * (n - i) % MOD * modInverse(i + 1, MOD) % MOD;
            }
            return res;
        };

        function<int(int, int)> countWays = [&](int left, int right) {
            if (right - left <= 1) return 1;
            int root = nums[left];
            int j = left + 1;
            while (j <= right && nums[j] < root) j++;
            int leftCount = j - left - 1;
            int rightCount = right - j + 1;
            return (comb(leftCount + rightCount, leftCount) * countWays(left + 1, j - 1) % MOD * countWays(j, right) % MOD) % MOD;
        };

        return (countWays(0, n - 1) - 1 + MOD) % MOD;
    }

    long long modInverse(long long a, long long mod) {
        long long m0 = mod, y = 0, x = 1;
        if (mod == 1) return 0;
        while (a > 1) {
            long long q = a / mod;
            long long t = mod;
            mod = a % mod, a = t;
            t = y;
            y = x - q * y;
            x = t;
        }
        if (x < 0) x += m0;
        return x;
    }
};