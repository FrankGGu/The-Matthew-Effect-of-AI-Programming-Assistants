class Solution {
public:
    int countHousePlacements(int n) {
        long long mod = 1e9 + 7;
        long long a = 1, b = 1;
        for (int i = 1; i <= n; ++i) {
            long long temp = (a + b) % mod;
            a = b;
            b = temp;
        }
        return (b * b) % mod;
    }
};