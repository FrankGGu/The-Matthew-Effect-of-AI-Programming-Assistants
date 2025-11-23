class Solution {
public:
    int maxDifference(vector<vector<int>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();
        int maxDiff = 0;

        vector<vector<int>> minVal(rows, vector<int>(cols, 0));
        vector<vector<int>> maxVal(rows, vector<int>(cols, 0));

        minVal[0][0] = grid[0][0];
        maxVal[0][0] = grid[0][0];

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (i > 0) {
                    minVal[i][j] = min(minVal[i][j], minVal[i-1][j]);
                    maxVal[i][j] = max(maxVal[i][j], maxVal[i-1][j]);
                }
                if (j > 0) {
                    minVal[i][j] = min(minVal[i][j], minVal[i][j-1]);
                    maxVal[i][j] = max(maxVal[i][j], maxVal[i][j-1]);
                }
                minVal[i][j] = min(minVal[i][j], grid[i][j]);
                maxVal[i][j] = max(maxVal[i][j], grid[i][j]);
            }
        }

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                maxDiff = max(maxDiff, abs(maxVal[i][j] - minVal[i][j]));
            }
        }

        return maxDiff;
    }
};