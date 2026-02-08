class Solution {
public:
    int numSpecial(std::vector<std::vector<int>>& mat) {
        int m = mat.size();
        int n = mat[0].size();

        std::vector<int> rowSums(m, 0);
        std::vector<int> colSums(n, 0);

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (mat[i][j] == 1) {
                    rowSums[i]++;
                    colSums[j]++;
                }
            }
        }

        int specialPositions = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (mat[i][j] == 1 && rowSums[i] == 1 && colSums[j] == 1) {
                    specialPositions++;
                }
            }
        }

        return specialPositions;
    }
};