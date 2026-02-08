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

        int max_area = 0;
        std::stack<int> s; // Stores indices of bars

        // Iterate through all bars, including a virtual bar of height 0 at the end
        // to ensure all bars remaining in the stack are processed.
        for (int i = 0; i <= n; ++i) {
            // Current height to consider. If i == n, it's 0 to pop remaining stack elements.
            int current_h = (i == n) ? 0 : heights[i];

            // While stack is not empty and the current bar is shorter than the bar at stack's top
            while (!s.empty() && current_h < heights[s.top()]) {
                int h = heights[s.top()]; // Height of the bar being popped
                s.pop();

                // Calculate width:
                // If stack becomes empty, it means the popped bar is the smallest
                // from index 0 up to current 'i'. So, width is 'i'.
                // Otherwise, width is 'i' - s.top() (index of previous smaller bar) - 1.
                int w = s.empty() ? i : (i - s.top() - 1);
                max_area = std::max(max_area, h * w);
            }
            s.push(i); // Push current bar's index onto the stack
        }

        return max_area;
    }
};