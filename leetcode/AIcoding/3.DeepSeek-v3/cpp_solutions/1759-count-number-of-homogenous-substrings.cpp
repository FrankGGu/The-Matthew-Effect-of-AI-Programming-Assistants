class Solution {
public:
    int countHomogenous(string s) {
        const int MOD = 1e9 + 7;
        long long res = 0;
        int n = s.size();
        for (int i = 0; i < n; ) {
            char current = s[i];
            int j = i;
            while (j < n && s[j] == current) {
                j++;
            }
            long long len = j - i;
            res += len * (len + 1) / 2;
            res %= MOD;
            i = j;
        }
        return res;
    }
};