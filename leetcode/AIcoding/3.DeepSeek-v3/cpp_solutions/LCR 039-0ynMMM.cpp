#include <vector>
#include <stack>
#include <algorithm>
using namespace std;

class Solution {
public:
    int largestRectangleArea(vector<int>& heights) {
        if (heights.empty()) return 0;
        heights.insert(heights.begin(), 0);
        heights.push_back(0);
        stack<int> stk;
        stk.push(0);
        int maxArea = 0;
        for (int i = 1; i < heights.size(); ++i) {
            while (heights[i] < heights[stk.top()]) {
                int h = heights[stk.top()];
                stk.pop();
                int w = i - stk.top() - 1;
                maxArea = max(maxArea, h * w);
            }
            stk.push(i);
        }
        return maxArea;
    }
};