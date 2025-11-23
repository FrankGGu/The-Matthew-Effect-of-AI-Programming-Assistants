class Solution {
public:
    int countWays(vector<vector<int>>& ranges) {
        sort(ranges.begin(), ranges.end());
        int mod = 1e9 + 7;
        long long count = 1;
        int n = ranges.size();
        int lastEnd = ranges[0][1];

        for (int i = 1; i < n; ++i) {
            if (ranges[i][0] <= lastEnd) {
                lastEnd = max(lastEnd, ranges[i][1]);
            } else {
                count = (count * 2) % mod;
                lastEnd = ranges[i][1];
            }
        }

        return count;
    }
};