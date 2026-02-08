class Solution {
public:
    long long countSubstrings(string s) {
        long long res = 0;
        int n = s.size();
        for (int i = 0; i < n; ++i) {
            if (s[i] == '1') {
                int j = i;
                while (j < n && s[j] == '1') {
                    ++j;
                }
                long long len = j - i;
                res += len * (len + 1) / 2;
                i = j - 1;
            }
        }
        return res;
    }
};