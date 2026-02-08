#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> slidingSubarrayBeauty(std::vector<int>& nums, int k) {
        std::vector<int> result;
        std::vector<int> freq(101, 0);

        for (int i = 0; i < k; ++i) {
            ++freq[nums[i]];
        }

        for (int i = 0; i <= nums.size() - k; ++i) {
            int beauty = 0;
            for (int j = 1; j <= 100; ++j) {
                if (freq[j] > 0) {
                    beauty = j;
                    break;
                }
            }
            result.push_back(beauty);

            if (i + k < nums.size()) {
                --freq[nums[i]];
                ++freq[nums[i + k]];
            }
        }

        return result;
    }
};