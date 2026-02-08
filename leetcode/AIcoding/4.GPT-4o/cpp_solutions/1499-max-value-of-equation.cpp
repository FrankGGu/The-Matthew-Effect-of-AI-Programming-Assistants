#include <vector>
#include <deque>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findMaxValueOfEquation(vector<vector<int>>& points, int k) {
        deque<int> dq;
        int maxValue = INT_MIN;

        for (const auto& point : points) {
            while (!dq.empty() && point[0] - points[dq.front()][0] > k) {
                dq.pop_front();
            }
            if (!dq.empty()) {
                maxValue = max(maxValue, point[0] + point[1] + points[dq.front()][1] - points[dq.front()][0]);
            }
            while (!dq.empty() && points[dq.back()][1] - points[dq.back()][0] <= point[1] - point[0]) {
                dq.pop_back();
            }
            dq.push_back(&point - &points[0]);
        }

        return maxValue;
    }
};