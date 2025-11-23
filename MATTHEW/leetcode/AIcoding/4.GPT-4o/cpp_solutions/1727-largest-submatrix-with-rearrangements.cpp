class Solution {
public:
    int largestSubmatrix(vector<vector<int>>& matrix) {
        int m = matrix.size();
        int n = matrix[0].size();
        vector<vector<int>> heights(m, vector<int>(n, 0));

        for (int j = 0; j < n; ++j) {
            for (int i = 0; i < m; ++i) {
                heights[i][j] = (matrix[i][j] == 0) ? 0 : (i == 0 ? 1 : heights[i - 1][j] + 1);
            }
        }

        int maxArea = 0;
        for (int i = 0; i < m; ++i) {
            sort(heights[i].begin(), heights[i].end(), greater<int>());
            for (int j = 0; j < n; ++j) {
                maxArea = max(maxArea, heights[i][j] * (j + 1));
            }
        }

        return maxArea;
    }
};