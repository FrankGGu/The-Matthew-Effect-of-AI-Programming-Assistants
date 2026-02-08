#include <vector>
#include <stack>
#include <algorithm>
using namespace std;

class Solution {
public:
    int maximalRectangle(vector<vector<char>>& matrix) {
        if (matrix.empty() || matrix[0].empty()) return 0;
        int rows = matrix.size();
        int cols = matrix[0].size();
        vector<int> heights(cols + 1, 0);
        int maxArea = 0;

        for (int i = 0; i < rows; ++i) {
            stack<int> st;
            for (int j = 0; j < cols; ++j) {
                heights[j] = (matrix[i][j] == '1') ? heights[j] + 1 : 0;
            }

            for (int j = 0; j <= cols; ++j) {
                while (!st.empty() && heights[st.top()] > heights[j]) {
                    int h = heights[st.top()];
                    st.pop();
                    int w = st.empty() ? j : j - st.top() - 1;
                    maxArea = max(maxArea, h * w);
                }
                st.push(j);
            }
        }

        return maxArea;
    }
};