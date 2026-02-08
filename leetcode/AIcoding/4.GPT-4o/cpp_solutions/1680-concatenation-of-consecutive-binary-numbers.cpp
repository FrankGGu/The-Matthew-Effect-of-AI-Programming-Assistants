class Solution {
public:
    int concatenatedBinary(int n) {
        long long result = 0;
        int mod = 1e9 + 7;
        for (int i = 1; i <= n; ++i) {
            result = ((result << (int)log2(i) + 1) % mod + i) % mod;
        }
        return result;
    }
};