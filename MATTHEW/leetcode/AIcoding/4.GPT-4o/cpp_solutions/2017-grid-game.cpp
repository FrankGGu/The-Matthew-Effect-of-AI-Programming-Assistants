class Solution {
public:
    long long gridGame(vector<vector<int>>& grid) {
        int n = grid[0].size();
        vector<long long> prefix(2, 0);
        for (int i = 0; i < n; i++) {
            prefix[0] += grid[0][i];
        }
        long long minTime = LLONG_MAX;
        long long top = 0, bottom = prefix[0];
        for (int i = 0; i < n; i++) {
            top += grid[0][i];
            bottom -= grid[0][i];
            minTime = min(minTime, max(top, prefix[1] - bottom));
        }
        return minTime;
    }
};