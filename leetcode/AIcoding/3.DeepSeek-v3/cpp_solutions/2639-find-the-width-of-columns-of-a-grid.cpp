class Solution {
public:
    vector<int> findColumnWidth(vector<vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return {};
        int n = grid[0].size();
        vector<int> res(n, 0);
        for (int j = 0; j < n; ++j) {
            int max_len = 0;
            for (int i = 0; i < m; ++i) {
                int num = grid[i][j];
                int len = num == 0 ? 1 : 0;
                if (num < 0) {
                    len = 1;
                    num = -num;
                }
                while (num > 0) {
                    len++;
                    num /= 10;
                }
                max_len = max(max_len, len);
            }
            res[j] = max_len;
        }
        return res;
    }
};