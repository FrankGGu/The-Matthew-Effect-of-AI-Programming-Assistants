class Solution {
public:
    int maxTrailingZeros(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        vector<vector<pair<int, int>>> prefix2(m, vector<pair<int, int>>(n + 1, {0, 0}));
        vector<vector<pair<int, int>>> prefix5(m, vector<pair<int, int>>(n + 1, {0, 0}));
        vector<vector<pair<int, int>>> prefix2_vert(m + 1, vector<pair<int, int>>(n, {0, 0}));
        vector<vector<pair<int, int>>> prefix5_vert(m + 1, vector<pair<int, int>>(n, {0, 0}));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                int cnt2 = 0, cnt5 = 0;
                int num = grid[i][j];
                while (num % 2 == 0) {
                    cnt2++;
                    num /= 2;
                }
                while (num % 5 == 0) {
                    cnt5++;
                    num /= 5;
                }
                prefix2[i][j + 1].first = prefix2[i][j].first + cnt2;
                prefix2[i][j + 1].second = prefix2[i][j].second + cnt5;
                prefix2_vert[i + 1][j].first = prefix2_vert[i][j].first + cnt2;
                prefix2_vert[i + 1][j].second = prefix2_vert[i][j].second + cnt5;
            }
        }

        for (int j = 0; j < n; ++j) {
            for (int i = 0; i < m; ++i) {
                int cnt2 = 0, cnt5 = 0;
                int num = grid[i][j];
                while (num % 2 == 0) {
                    cnt2++;
                    num /= 2;
                }
                while (num % 5 == 0) {
                    cnt5++;
                    num /= 5;
                }
                prefix5[i][j + 1].first = prefix5[i][j].first + cnt2;
                prefix5[i][j + 1].second = prefix5[i][j].second + cnt5;
                prefix5_vert[i + 1][j].first = prefix5_vert[i][j].first + cnt2;
                prefix5_vert[i + 1][j].second = prefix5_vert[i][j].second + cnt5;
            }
        }

        int res = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                int cnt2 = 0, cnt5 = 0;
                int num = grid[i][j];
                while (num % 2 == 0) {
                    cnt2++;
                    num /= 2;
                }
                while (num % 5 == 0) {
                    cnt5++;
                    num /= 5;
                }

                int left2 = prefix2[i][j + 1].first;
                int left5 = prefix2[i][j + 1].second;
                int right2 = prefix2[i][n].first - prefix2[i][j].first;
                int right5 = prefix2[i][n].second - prefix2[i][j].second;

                int up2 = prefix2_vert[i + 1][j].first;
                int up5 = prefix2_vert[i + 1][j].second;
                int down2 = prefix2_vert[m][j].first - prefix2_vert[i][j].first;
                int down5 = prefix2_vert[m][j].second - prefix2_vert[i][j].second;

                int lu2 = left2 + up2 - cnt2;
                int lu5 = left5 + up5 - cnt5;
                res = max(res, min(lu2, lu5));

                int ld2 = left2 + down2 - cnt2;
                int ld5 = left5 + down5 - cnt5;
                res = max(res, min(ld2, ld5));

                int ru2 = right2 + up2 - cnt2;
                int ru5 = right5 + up5 - cnt5;
                res = max(res, min(ru2, ru5));

                int rd2 = right2 + down2 - cnt2;
                int rd5 = right5 + down5 - cnt5;
                res = max(res, min(rd2, rd5));
            }
        }
        return res;
    }
};