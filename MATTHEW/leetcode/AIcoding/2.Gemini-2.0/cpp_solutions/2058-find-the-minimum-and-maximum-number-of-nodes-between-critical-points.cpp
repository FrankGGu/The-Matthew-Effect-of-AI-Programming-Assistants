#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> nodesBetweenCriticalPoints(vector<int>& nums) {
        vector<int> criticalPoints;
        for (int i = 1; i < nums.size() - 1; ++i) {
            if ((nums[i] > nums[i - 1] && nums[i] > nums[i + 1]) || (nums[i] < nums[i - 1] && nums[i] < nums[i + 1])) {
                criticalPoints.push_back(i);
            }
        }

        if (criticalPoints.size() < 2) {
            return {-1, -1};
        }

        int minDistance = INT_MAX;
        for (int i = 1; i < criticalPoints.size(); ++i) {
            minDistance = min(minDistance, criticalPoints[i] - criticalPoints[i - 1]);
        }

        return {minDistance, criticalPoints.back() - criticalPoints.front()};
    }
};