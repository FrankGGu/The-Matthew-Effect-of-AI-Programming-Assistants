class Solution {
public:
    int numWays(string s) {
        const int MOD = 1e9 + 7;
        int n = s.size();
        int total = 0;
        for (char c : s) {
            if (c == '1') total++;
        }
        if (total % 3 != 0) return 0;
        if (total == 0) {
            return (long long)(n - 1) * (n - 2) / 2 % MOD;
        }
        int target = total / 3;
        int cnt = 0;
        long long ways1 = 0, ways2 = 0;
        for (char c : s) {
            if (c == '1') cnt++;
            if (cnt == target) ways1++;
            if (cnt == 2 * target) ways2++;
        }
        return ways1 * ways2 % MOD;
    }
};