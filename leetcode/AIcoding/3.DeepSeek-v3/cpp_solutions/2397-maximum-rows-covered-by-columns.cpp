class Solution {
public:
    int maximumRows(vector<vector<int>>& matrix, int numSelect) {
        int m = matrix.size();
        int n = matrix[0].size();
        int maxRows = 0;

        for (int mask = 0; mask < (1 << n); ++mask) {
            if (__builtin_popcount(mask) != numSelect) {
                continue;
            }

            int covered = 0;
            for (int i = 0; i < m; ++i) {
                bool isCovered = true;
                for (int j = 0; j < n; ++j) {
                    if (matrix[i][j] == 1 && !(mask & (1 << j))) {
                        isCovered = false;
                        break;
                    }
                }
                if (isCovered) {
                    covered++;
                }
            }
            maxRows = max(maxRows, covered);
        }

        return maxRows;
    }
};