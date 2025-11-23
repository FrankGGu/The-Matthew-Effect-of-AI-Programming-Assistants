#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    int maximalRectangle(vector<vector<char>>& matrix) {
        if (matrix.empty() || matrix[0].empty()) return 0;

        int rows = matrix.size();
        int cols = matrix[0].size();
        vector<int> heights(cols, 0);
        int maxArea = 0;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (matrix[i][j] == '1') {
                    heights[j] += 1;
                } else {
                    heights[j] = 0;
                }
            }
            maxArea = max(maxArea, largestRectangleArea(heights));
        }

        return maxArea;
    }

private:
    int largestRectangleArea(vector<int>& heights) {
        stack<int> s;
        int maxArea = 0;
        int i = 0;
        while (i < heights.size() || !s.empty()) {
            if (s.empty() || (i < heights.size() && heights[i] >= heights[s.top()])) {
                s.push(i++);
            } else {
                int top = s.top();
                s.pop();
                int area = heights[top] * (s.empty() ? i : i - s.top() - 1);
                maxArea = max(maxArea, area);
            }
        }
        return maxArea;
    }
};