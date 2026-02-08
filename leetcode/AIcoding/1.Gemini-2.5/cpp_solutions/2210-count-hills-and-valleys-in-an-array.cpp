#include <vector>
#include <numeric>

class Solution {
public:
    int countHillValley(std::vector<int>& nums) {
        std::vector<int> compressed_nums;
        if (nums.empty()) {
            return 0;
        }

        compressed_nums.push_back(nums[0]);
        for (int i = 1; i < nums.size(); ++i) {
            if (nums[i] != nums[i-1]) {
                compressed_nums.push_back(nums[i]);
            }
        }

        if (compressed_nums.size() < 3) {
            return 0;
        }

        int count = 0;
        for (int i = 1; i < compressed_nums.size() - 1; ++i) {
            // Check for hill
            if (compressed_nums[i] > compressed_nums[i-1] && compressed_nums[i] > compressed_nums[i+1]) {
                count++;
            } 
            // Check for valley
            else if (compressed_nums[i] < compressed_nums[i-1] && compressed_nums[i] < compressed_nums[i+1]) {
                count++;
            }
        }

        return count;
    }
};