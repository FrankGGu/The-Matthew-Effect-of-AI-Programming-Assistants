#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxValueAfterReverse(vector<int>& nums) {
        int n = nums.size();
        int originalValue = 0;
        int maxChange = 0;
        int minMaxDiff = INT_MAX;
        int maxMinDiff = INT_MIN;

        for (int i = 0; i < n - 1; ++i) {
            int a = nums[i];
            int b = nums[i + 1];
            originalValue += abs(a - b);
            minMaxDiff = min(minMaxDiff, max(a, b));
            maxMinDiff = max(maxMinDiff, min(a, b));
        }

        maxChange = max(maxChange, abs(nums[0] - nums[1]) - abs(nums[n - 2] - nums[n - 1]));
        maxChange = max(maxChange, abs(nums[n - 1] - nums[n - 2]) - abs(nums[1] - nums[0]));
        maxChange = max(maxChange, 2 * (maxMinDiff - minMaxDiff));

        return originalValue + maxChange;
    }
};