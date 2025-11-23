#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> smallerNumbersThanCurrent(std::vector<int>& nums) {
        std::vector<int> freq(101, 0);
        for (int num : nums) {
            freq[num]++;
        }

        std::vector<int> smaller_counts(101, 0);
        smaller_counts[0] = 0;
        for (int i = 1; i <= 100; ++i) {
            smaller_counts[i] = smaller_counts[i - 1] + freq[i - 1];
        }

        std::vector<int> result;
        result.reserve(nums.size());

        for (int num : nums) {
            result.push_back(smaller_counts[num]);
        }

        return result;
    }
};