#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int solve(vector<int>& nums) {
        int n = nums.size();
        int max_sum = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                for (int k = j + 1; k < n; ++k) {
                    max_sum = max(max_sum, nums[i] + nums[j] + nums[k]);
                }
            }
        }
        return max_sum;
    }

    int maximumSum(vector<int>& nums) {
        return solve(nums);
    }
};