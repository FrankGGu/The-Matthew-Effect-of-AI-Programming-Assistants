#include <vector>
#include <stack>
#include <algorithm>

class Solution {
public:
    int largestRectangleArea(std::vector<int>& heights) {
        std::stack<int> st;
        int max_area = 0;
        int n = heights.size();

        for (int i = 0; i <= n; ++i) {
            int h = (i == n) ? 0 : heights[i];
            while (!st.empty() && h < heights[st.top()]) {
                int top_h = heights[st.top()];
                st.pop();
                int width = st.empty() ? i : i - st.top() - 1;
                max_area = std::max(max_area, top_h * width);
            }
            st.push(i);
        }
        return max_area;
    }

    int maximalRectangle(std::vector<std::vector<char>>& matrix) {
        if (matrix.empty() || matrix[0].empty()) {
            return 0;
        }

        int max_rec_area = 0;
        int num_rows = matrix.size();
        int num_cols = matrix[0].size();
        std::vector<int> heights(num_cols, 0);

        for (int i = 0; i < num_rows; ++i) {
            for (int j = 0; j < num_cols; ++j) {
                if (matrix[i][j] == '1') {
                    heights[j]++;
                } else {
                    heights[j] = 0;
                }
            }
            max_rec_area = std::max(max_rec_area, largestRectangleArea(heights));
        }

        return max_rec_area;
    }
};