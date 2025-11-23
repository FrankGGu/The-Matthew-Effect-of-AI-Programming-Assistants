class Solution {
public:
    int countEqualSubmatrices(vector<vector<int>>& matrix, int x, int y) {
        int m = matrix.size(), n = matrix[0].size();
        int count = 0;

        for (int r1 = 0; r1 < m; ++r1) {
            for (int c1 = 0; c1 < n; ++c1) {
                int xCount = 0, yCount = 0;

                for (int r2 = r1; r2 < m; ++r2) {
                    for (int c2 = c1; c2 < n; ++c2) {
                        if (matrix[r2][c2] == x) xCount++;
                        if (matrix[r2][c2] == y) yCount++;

                        if (xCount == yCount) count++;
                    }
                }
            }
        }

        return count;
    }
};