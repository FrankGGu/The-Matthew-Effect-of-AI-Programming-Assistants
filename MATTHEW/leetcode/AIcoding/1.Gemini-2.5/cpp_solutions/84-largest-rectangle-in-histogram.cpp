#include <vector>
#include <stack>
#include <algorithm>

class Solution {
public:
    int largestRectangleArea(std::vector<int>& heights) {
        int n = heights.size();
        int max_area = 0;
        std::stack<int> st; // Stores indices of bars in increasing order of height

        for (int i = 0; i <= n; ++i) {
            // Use current_h = 0 for i == n to ensure all remaining bars in stack are processed
            int current_h = (i == n) ? 0 : heights[i];

            // While the stack is not empty and the current bar is shorter than the bar at stack's top
            while (!st.empty() && current_h < heights[st.top()]) {
                int h_idx = st.top();
                st.pop();
                int h = heights[h_idx]; // Height of the rectangle

                int width;
                if (st.empty()) {
                    // If stack is empty, it means this bar is the smallest so far,
                    // and extends from index 0 to i-1.
                    width = i;
                } else {
                    // The width is from the bar after st.top() up to i-1.
                    // st.top() is the index of the first bar to the left that is shorter than h.
                    // i is the index of the first bar to the right that is shorter than h.
                    width = i - st.top() - 1;
                }
                max_area = std::max(max_area, h * width);
            }
            st.push(i);
        }
        return max_area;
    }
};