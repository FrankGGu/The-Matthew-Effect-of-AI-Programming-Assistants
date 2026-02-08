#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumGap(vector<int>& nums) {
        int n = nums.size();
        if (n < 2) return 0;
        sort(nums.begin(), nums.end());
        int max_gap = 0;
        for (int i = 1; i < n; ++i) {
            max_gap = max(max_gap, nums[i] - nums[i - 1]);
        }
        return max_gap;
    }
};