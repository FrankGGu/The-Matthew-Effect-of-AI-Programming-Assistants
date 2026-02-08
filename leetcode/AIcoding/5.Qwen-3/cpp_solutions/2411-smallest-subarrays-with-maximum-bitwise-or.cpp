#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> smallestSubarrays(std::vector<int>& nums) {
        int n = nums.size();
        std::vector<int> result(n, 0);

        for (int i = 0; i < n; ++i) {
            int currentOr = nums[i];
            result[i] = nums[i];
            for (int j = i + 1; j < n; ++j) {
                currentOr |= nums[j];
                result[i] = std::max(result[i], currentOr);
            }
        }

        return result;
    }
};