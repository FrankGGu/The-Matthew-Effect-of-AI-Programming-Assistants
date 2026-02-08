#include <vector>
#include <string>

class Solution {
public:
    int numOfPairs(std::vector<std::string>& nums, std::string target) {
        int count = 0;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i != j) {
                    if (nums[i] + nums[j] == target) {
                        count++;
                    }
                }
            }
        }
        return count;
    }
};