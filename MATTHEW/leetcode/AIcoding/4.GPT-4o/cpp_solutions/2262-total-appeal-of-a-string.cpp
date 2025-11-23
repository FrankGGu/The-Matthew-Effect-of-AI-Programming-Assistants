class Solution {
public:
    long long appealSum(string s) {
        long long totalAppeal = 0, lastPosition[26] = {0}, n = s.size();
        for (int i = 0; i < n; ++i) {
            totalAppeal += (i + 1) - lastPosition[s[i] - 'a'];
            lastPosition[s[i] - 'a'] = i + 1;
        }
        return totalAppeal;
    }
};