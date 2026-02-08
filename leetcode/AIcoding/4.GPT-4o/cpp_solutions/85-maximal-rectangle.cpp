class Solution {
public:
    int maximalRectangle(vector<vector<char>>& matrix) {
        if (matrix.empty()) return 0;
        int maxArea = 0, n = matrix.size(), m = matrix[0].size();
        vector<int> height(m, 0);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                height[j] = (matrix[i][j] == '1') ? height[j] + 1 : 0;
            }
            maxArea = max(maxArea, largestRectangleArea(height));
        }

        return maxArea;
    }

    int largestRectangleArea(vector<int>& heights) {
        stack<int> s;
        heights.push_back(0);
        int maxArea = 0;

        for (int i = 0; i < heights.size(); ++i) {
            while (!s.empty() && heights[s.top()] > heights[i]) {
                int h = heights[s.top()];
                s.pop();
                int width = s.empty() ? i : i - s.top() - 1;
                maxArea = max(maxArea, h * width);
            }
            s.push(i);
        }

        return maxArea;
    }
};