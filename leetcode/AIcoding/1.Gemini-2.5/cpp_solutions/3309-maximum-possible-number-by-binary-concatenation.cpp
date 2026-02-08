class Solution {
public:
    int concatenatedBinary(int n) {
        long long result = 0;
        long long MOD = 1000000007;

        for (int i = 1; i <= n; ++i) {
            int k = 0;
            unsigned int temp_i = i;
            while (temp_i > 0) {
                temp_i >>= 1;
                k++;
            }

            result = (result * (1LL << k) + i) % MOD;
        }

        return static_cast<int>(result);
    }
};