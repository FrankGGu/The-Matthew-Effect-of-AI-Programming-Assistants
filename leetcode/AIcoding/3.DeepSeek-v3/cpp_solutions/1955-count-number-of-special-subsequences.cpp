class Solution {
public:
    int countSpecialSubsequences(vector<int>& nums) {
        const int MOD = 1e9 + 7;
        long long a = 0, b = 0, c = 0;
        for (int num : nums) {
            if (num == 0) {
                a = (2 * a + 1) % MOD;
            } else if (num == 1) {
                b = (2 * b + a) % MOD;
            } else if (num == 2) {
                c = (2 * c + b) % MOD;
            }
        }
        return c;
    }
};