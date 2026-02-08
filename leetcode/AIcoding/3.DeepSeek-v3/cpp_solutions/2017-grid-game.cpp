class Solution {
public:
    long long gridGame(vector<vector<int>>& grid) {
        int n = grid[0].size();
        vector<long long> prefix1(n + 1, 0);
        vector<long long> prefix2(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            prefix1[i] = prefix1[i - 1] + grid[0][i - 1];
            prefix2[i] = prefix2[i - 1] + grid[1][i - 1];
        }

        long long res = LLONG_MAX;
        for (int i = 1; i <= n; ++i) {
            long long option1 = prefix1[n] - prefix1[i];
            long long option2 = prefix2[i - 1];
            res = min(res, max(option1, option2));
        }

        return res;
    }
};