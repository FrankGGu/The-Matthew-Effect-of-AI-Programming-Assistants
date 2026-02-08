class Solution {
public:
    int maximumRows(vector<vector<int>>& matrix, int numSelect) {
        int m = matrix.size(), n = matrix[0].size();
        int maxRows = 0;

        for (int mask = 0; mask < (1 << n); ++mask) {
            if (__builtin_popcount(mask) == numSelect) {
                vector<bool> covered(m, false);
                for (int j = 0; j < n; ++j) {
                    if (mask & (1 << j)) {
                        for (int i = 0; i < m; ++i) {
                            if (matrix[i][j] == 1) {
                                covered[i] = true;
                            }
                        }
                    }
                }
                maxRows = max(maxRows, count(covered.begin(), covered.end(), true));
            }
        }
        return maxRows;
    }
};