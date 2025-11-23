class Solution {
public:
    long long numberOfWays(string s) {
        long long n = s.length();
        long long ans = 0;
        for (int i = 1; i < n - 1; ++i) {
            long long left0 = 0, left1 = 0, right0 = 0, right1 = 0;
            for (int j = 0; j < i; ++j) {
                if (s[j] == '0') left0++;
                else left1++;
            }
            for (int j = i + 1; j < n; ++j) {
                if (s[j] == '0') right0++;
                else right1++;
            }
            if (s[i] == '0') {
                ans += left1 * right1;
            } else {
                ans += left0 * right0;
            }
        }
        return ans;
    }
};