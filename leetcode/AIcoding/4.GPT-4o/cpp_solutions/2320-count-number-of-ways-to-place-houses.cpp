class Solution {
public:
    int countHousePlacements(int n) {
        const int MOD = 1e9 + 7;
        long long a = 1, b = 1;
        for (int i = 0; i < n; ++i) {
            long long temp = (a + b) % MOD;
            a = b;
            b = temp;
        }
        return (b * b) % MOD;
    }
};