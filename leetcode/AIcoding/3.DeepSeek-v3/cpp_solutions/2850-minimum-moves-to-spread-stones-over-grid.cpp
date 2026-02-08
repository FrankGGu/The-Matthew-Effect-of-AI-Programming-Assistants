class Solution {
public:
    int minimumMoves(vector<vector<int>>& grid) {
        vector<pair<int, int>> from, to;
        for (int i = 0; i < 3; ++i) {
            for (int j = 0; j < 3; ++j) {
                if (grid[i][j] > 1) {
                    for (int k = 0; k < grid[i][j] - 1; ++k) {
                        from.emplace_back(i, j);
                    }
                } else if (grid[i][j] == 0) {
                    to.emplace_back(i, j);
                }
            }
        }

        int res = INT_MAX;
        vector<int> perm(from.size());
        for (int i = 0; i < perm.size(); ++i) {
            perm[i] = i;
        }

        do {
            int total = 0;
            for (int i = 0; i < perm.size(); ++i) {
                int x1 = from[i].first, y1 = from[i].second;
                int x2 = to[perm[i]].first, y2 = to[perm[i]].second;
                total += abs(x1 - x2) + abs(y1 - y2);
            }
            res = min(res, total);
        } while (next_permutation(perm.begin(), perm.end()));

        return res;
    }
};