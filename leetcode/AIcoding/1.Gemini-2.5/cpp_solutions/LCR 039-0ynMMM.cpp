#include <vector>
#include <stack>
#include <algorithm>

class Solution {
public:
    int largestRectangleArea(std::vector<int>& heights) {
        int n = heights.size();
        if (n == 0) {
            return 0;
        }

        int maxArea = 0;
        std::stack<int> st;

        for (int i = 0; i <= n; ++i) {
            int currentHeight = (i == n) ? 0 : heights[i];

            while (!st.empty() && currentHeight < heights[st.top()]) {
                int h = heights[st.top()];
                st.pop();

                int width;
                if (st.empty()) {
                    width = i;
                } else {
                    width = i - st.top() - 1;
                }
                maxArea = std::max(maxArea, h * width);
            }
            st.push(i);
        }
        return maxArea;
    }
};