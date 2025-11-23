class Solution {
public:
    long long appealSum(string s) {
        long long n = s.length();
        vector<long long> last(26, -1);
        long long ans = 0;
        for (int i = 0; i < n; ++i) {
            int c = s[i] - 'a';
            ans += (i - last[c]) * (n - i);
            last[c] = i;
        }
        return ans;
    }
};