class Solution {
public:
    int countHomogenous(string s) {
        long long count = 0, total = 0;
        const int MOD = 1e9 + 7;

        for (int i = 0; i < s.size(); ++i) {
            if (i > 0 && s[i] == s[i - 1]) {
                count = (count + 1) % MOD;
            } else {
                count = 1;
            }
            total = (total + count) % MOD;
        }

        return total;
    }
};