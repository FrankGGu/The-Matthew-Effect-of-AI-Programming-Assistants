class Solution {
public:
    int minimumCost(string s) {
        int n = s.size();
        int res = 0;
        for (int i = 1; i < n; ++i) {
            if (s[i] != s[i-1]) {
                res += min(i, n - i);
            }
        }
        return res;
    }
};