#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxDifference(vector<int>& nums) {
        int n = nums.size();
        if (n <= 1) {
            return 0;
        }

        int maxDiff = 0;
        for (int i = 0; i < n; ++i) {
            int diff = abs(nums[i] - nums[(i + 1) % n]);
            maxDiff = max(maxDiff, diff);
        }

        return maxDiff;
    }
};