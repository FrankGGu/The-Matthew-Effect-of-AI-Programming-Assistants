#include <numeric>

class Solution {
public:
    int subarrayLCM(vector<int>& nums, int k) {
        int count = 0;
        for (int i = 0; i < nums.size(); ++i) {
            int currentLCM = nums[i];
            for (int j = i; j < nums.size(); ++j) {
                currentLCM = std::lcm(currentLCM, nums[j]);
                if (currentLCM == k) {
                    count++;
                } else if (currentLCM > k) {
                    break;
                }
            }
        }
        return count;
    }
};