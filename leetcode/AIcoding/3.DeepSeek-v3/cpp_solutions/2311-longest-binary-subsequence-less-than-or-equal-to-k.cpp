class Solution {
public:
    int longestSubsequence(string s, int k) {
        int n = s.size();
        int res = 0;
        long long val = 0;
        for (int i = n - 1; i >= 0; --i) {
            if (s[i] == '0') {
                res++;
            } else {
                if (res < 30 && val + (1LL << res) <= k) {
                    val += (1LL << res);
                    res++;
                }
            }
        }
        return res;
    }
};