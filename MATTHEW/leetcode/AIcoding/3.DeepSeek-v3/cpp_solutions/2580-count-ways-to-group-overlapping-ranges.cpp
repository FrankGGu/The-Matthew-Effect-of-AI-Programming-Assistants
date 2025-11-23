class Solution {
public:
    int countWays(vector<vector<int>>& ranges) {
        sort(ranges.begin(), ranges.end());
        int res = 1, end = ranges[0][1];
        const int mod = 1e9 + 7;

        for (int i = 1; i < ranges.size(); ++i) {
            if (ranges[i][0] > end) {
                res = res * 2 % mod;
            }
            end = max(end, ranges[i][1]);
        }

        return res * 2 % mod;
    }
};