#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxSubarraySumCircular(vector<int>& nums) {
        int n = nums.size();
        int max_kadane = kadane(nums);
        int max_wrap = 0;
        for (int i = 0; i < n; i++) {
            max_wrap += nums[i];
            nums[i] = -nums[i];
        }
        max_wrap = max_wrap + kadane(nums);
        if (max_wrap > max_kadane && max_wrap != 0)
            return max_wrap;
        else if (max_kadane == 0 && all_negative(nums))
            return *max_element(nums.begin(), nums.end());
        else
            return max_kadane;
    }

private:
    int kadane(vector<int>& nums) {
        int max_so_far = nums[0];
        int current_max = nums[0];
        for (int i = 1; i < nums.size(); i++) {
            current_max = max(nums[i], current_max + nums[i]);
            max_so_far = max(max_so_far, current_max);
        }
        return max_so_far;
    }

    bool all_negative(vector<int>& nums) {
        for (int num : nums) {
            if (num >= 0)
                return false;
        }
        return true;
    }
};