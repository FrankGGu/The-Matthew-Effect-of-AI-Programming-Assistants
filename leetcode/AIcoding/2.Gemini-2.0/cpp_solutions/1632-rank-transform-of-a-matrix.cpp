#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> matrixRankTransform(vector<vector<int>>& matrix) {
        int m = matrix.size();
        int n = matrix[0].size();

        vector<vector<int>> ans(m, vector<int>(n));
        vector<int> rank(m + n, 0);

        vector<tuple<int, int, int>> cells;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                cells.emplace_back(matrix[i][j], i, j);
            }
        }
        sort(cells.begin(), cells.end());

        int i = 0;
        while (i < cells.size()) {
            int j = i;
            vector<int> group_rank = rank;
            vector<tuple<int, int>> group;

            while (j < cells.size() && get<0>(cells[i]) == get<0>(cells[j])) {
                int row = get<1>(cells[j]);
                int col = get<2>(cells[j]);
                group_rank[row] = max(group_rank[row], rank[row]);
                group_rank[m + col] = max(group_rank[m + col], rank[m + col]);
                j++;
            }

            while (i < j) {
                int row = get<1>(cells[i]);
                int col = get<2>(cells[i]);
                int r = max(group_rank[row], group_rank[m + col]) + 1;
                ans[row][col] = r;
                group.emplace_back(row, m + col);
                i++;
            }

            for (auto [row, col] : group) {
                rank[row] = ans[row][get<2>(cells[i - group.size()])];
                rank[col] = ans[get<1>(cells[i - group.size()])][col - m];
            }
        }

        return ans;
    }
};