class Solution {
public:
    int countHomogenous(string s) {
        long long ans = 0;
        int mod = 1e9 + 7;
        int count = 1;
        for (int i = 1; i < s.length(); ++i) {
            if (s[i] == s[i - 1]) {
                count++;
            } else {
                ans = (ans + (long long)count * (count + 1) / 2) % mod;
                count = 1;
            }
        }
        ans = (ans + (long long)count * (count + 1) / 2) % mod;
        return (int)ans;
    }
};