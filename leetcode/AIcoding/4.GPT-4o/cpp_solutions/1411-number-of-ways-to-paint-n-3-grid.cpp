class Solution {
public:
    int numOfWays(int n) {
        const int MOD = 1e9 + 7;
        long long same = 6, diff = 30;
        for (int i = 1; i < n; ++i) {
            long long newSame = (same * 3 + diff * 2) % MOD;
            long long newDiff = (same * 2 + diff * 3) % MOD;
            same = newSame;
            diff = newDiff;
        }
        return (same + diff) % MOD;
    }
};