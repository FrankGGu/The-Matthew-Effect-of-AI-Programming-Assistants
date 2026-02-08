#include <vector>
#include <deque>
using namespace std;

class Solution {
public:
    vector<int> maxSlidingWindow(vector<int>& heights, int k) {
        deque<int> dq;
        vector<int> result;

        for (int i = 0; i < heights.size(); ++i) {
            if (!dq.empty() && dq.front() == i - k) {
                dq.pop_front();
            }

            while (!dq.empty() && heights[dq.back()] < heights[i]) {
                dq.pop_back();
            }

            dq.push_back(i);

            if (i >= k - 1) {
                result.push_back(heights[dq.front()]);
            }
        }

        return result;
    }
};