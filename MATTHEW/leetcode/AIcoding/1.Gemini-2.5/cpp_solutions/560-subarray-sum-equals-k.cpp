#include <vector>
#include <unordered_map>

class Solution {
public:
    int subarraySum(std::vector<int>& nums, int k) {
        int count = 0;
        int currentSum = 0;
        std::unordered_map<int, int> prefixSums;
        prefixSums[0] = 1;

        for (int num : nums) {
            currentSum += num;
            if (prefixSums.count(currentSum - k)) {
                count += prefixSums[currentSum - k];
            }
            prefixSums[currentSum]++;
        }

        return count;
    }
};