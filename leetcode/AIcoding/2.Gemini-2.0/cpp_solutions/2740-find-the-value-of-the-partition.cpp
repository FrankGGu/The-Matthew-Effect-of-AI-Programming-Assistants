#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int findValueOfPartition(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int minDiff = INT_MAX;
        for (int i = 0; i < nums.size() - 1; ++i) {
            minDiff = min(minDiff, nums[i + 1] - nums[i]);
        }
        return minDiff;
    }
};