#include <vector>
#include <stack>
#include <algorithm>

class Solution {
public:
    int largestRectangleArea(std::vector<int>& heights) {
        int n = heights.size();
        std::stack<int> st;
        int max_area = 0;

        for (int i = 0; i <= n; ++i) {
            int current_h = (i == n) ? 0 : heights[i];
            while (!st.empty() && heights[st.top()] >= current_h) {
                int h = heights[st.top()];
                st.pop();
                int width = st.empty() ? i : i - st.top() - 1;
                max_area = std::max(max_area, h * width);
            }
            st.push(i);
        }
        return max_area;
    }

    int maximalRectangle(std::vector<std::vector<char>>& matrix) {
        if (matrix.empty() || matrix[0].empty()) {
            return 0;
        }

        int m = matrix.size();
        int n = matrix[0].size();
        std::vector<int> heights(n, 0);
        int max_overall_area = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (matrix[i][j] == '1') {
                    heights[j]++;
                } else {
                    heights[j] = 0;
                }
            }
            max_overall_area = std::max(max_overall_area, largestRectangleArea(heights));
        }

        return max_overall_area;
    }
};