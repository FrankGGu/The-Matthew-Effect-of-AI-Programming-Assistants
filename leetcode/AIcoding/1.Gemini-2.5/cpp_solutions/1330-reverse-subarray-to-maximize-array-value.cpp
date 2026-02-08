#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxValueAfterReverse(vector<int>& nums) {
        int n = nums.size();
        int sum = 0;
        int min_diff = INT_MAX;
        int max_diff = INT_MIN;
        int extra = 0;

        for (int i = 0; i < n - 1; ++i) {
            int a = nums[i];
            int b = nums[i + 1];
            int val = abs(a - b);
            sum += val;
            min_diff = min(min_diff, max(a, b));
            max_diff = max(max_diff, min(a, b));
        }

        extra = max(extra, abs(nums[0] - nums[1]) - abs(nums[0] - nums[n - 1]));
        extra = max(extra, abs(nums[n - 1] - nums[n - 2]) - abs(nums[n - 1] - nums[0]));
        extra = max(extra, 2 * (min_diff - max_diff));

        return sum + extra;
    }
};