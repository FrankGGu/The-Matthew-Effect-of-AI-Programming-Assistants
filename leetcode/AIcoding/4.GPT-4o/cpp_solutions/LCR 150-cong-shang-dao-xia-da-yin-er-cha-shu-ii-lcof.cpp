class Solution {
public:
    int numWays(int n) {
        if (n == 0) return 1;
        if (n == 1) return 1;
        long long mod = 1e9 + 7;
        long long a = 1, b = 1, c = 0;
        for (int i = 2; i <= n; ++i) {
            c = (a + b) % mod;
            a = b;
            b = c;
        }
        return b;
    }
};