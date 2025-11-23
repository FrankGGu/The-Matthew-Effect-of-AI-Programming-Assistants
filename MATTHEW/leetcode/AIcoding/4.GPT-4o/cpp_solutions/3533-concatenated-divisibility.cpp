class Solution {
public:
    int concatenatedBinary(int n) {
        long long res = 0;
        const int MOD = 1e9 + 7;
        for (int i = 1; i <= n; ++i) {
            int len = log2(i) + 1;
            res = ((res << len) + i) % MOD;
        }
        return res;
    }
};