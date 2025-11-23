#include <vector>
#include <algorithm>

class Solution {
public:
    int partitionArray(std::vector<int>& nums, int k) {
        std::sort(nums.begin(), nums.end());

        int partitions = 1;
        int currentMin = nums[0];

        for (int i = 1; i < nums.size(); ++i) {
            if (nums[i] - currentMin > k) {
                partitions++;
                currentMin = nums[i];
            }
        }

        return partitions;
    }
};