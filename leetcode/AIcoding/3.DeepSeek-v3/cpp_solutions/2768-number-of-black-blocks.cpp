class Solution {
public:
    vector<long long> countBlackBlocks(int m, int n, vector<vector<int>>& coordinates) {
        unordered_map<long long, int> cnt;
        for (const auto& coord : coordinates) {
            int x = coord[0], y = coord[1];
            for (int dx = 0; dx <= 1; ++dx) {
                for (int dy = 0; dy <= 1; ++dy) {
                    int nx = x - dx;
                    int ny = y - dy;
                    if (nx >= 0 && nx < m - 1 && ny >= 0 && ny < n - 1) {
                        long long key = (long long)nx * n + ny;
                        cnt[key]++;
                    }
                }
            }
        }
        vector<long long> res(5, 0);
        for (const auto& [_, v] : cnt) {
            res[v]++;
        }
        long long total = (long long)(m - 1) * (n - 1);
        res[0] = total - res[1] - res[2] - res[3] - res[4];
        return res;
    }
};