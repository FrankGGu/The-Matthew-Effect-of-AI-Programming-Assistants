#include <iostream>
#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numSubarrayLCM(int target, vector<int>& nums) {
        int count = 0;
        for (int i = 0; i < nums.size(); ++i) {
            int current_lcm = nums[i];
            if (current_lcm == target) ++count;
            for (int j = i + 1; j < nums.size(); ++j) {
                current_lcm = (nums[j] * current_lcm) / gcd(nums[j], current_lcm);
                if (current_lcm == target) ++count;
                else if (current_lcm > target) break;
            }
        }
        return count;
    }
};