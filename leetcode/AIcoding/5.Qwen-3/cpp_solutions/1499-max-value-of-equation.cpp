#include <iostream>
#include <vector>
#include <deque>
#include <cmath>

using namespace std;

class Solution {
public:
    int findMaxValueOfEquation(vector<vector<int>>& points, int k) {
        int maxVal = INT_MIN;
        deque<pair<int, int>> q;

        for (auto& point : points) {
            int x = point[0], y = point[1];

            while (!q.empty() && q.front().first < x - k) {
                q.pop_front();
            }

            if (!q.empty()) {
                maxVal = max(maxVal, q.front().second + x + y);
            }

            while (!q.empty() && q.back().second <= y - x) {
                q.pop_back();
            }

            q.push_back({x, y - x});
        }

        return maxVal;
    }
};