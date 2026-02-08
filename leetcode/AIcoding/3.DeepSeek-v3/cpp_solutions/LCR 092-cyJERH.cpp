class Solution {
public:
    int minFlipsMonoIncr(string s) {
        int n = s.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + (s[i] == '1' ? 1 : 0);
        }
        int res = INT_MAX;
        for (int i = 0; i <= n; ++i) {
            res = min(res, prefix[i] + (n - i) - (prefix[n] - prefix[i]));
        }
        return res;
    }
};