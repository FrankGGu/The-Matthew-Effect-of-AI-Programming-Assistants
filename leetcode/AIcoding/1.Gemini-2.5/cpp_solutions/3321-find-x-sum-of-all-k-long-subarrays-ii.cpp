#include <vector>

class Solution {
public:
    std::vector<int> xSumSubarrays(std::vector<int>& nums, int k) {
        int n = nums.size();
        if (n < k) {
            return {};
        }

        std::vector<int> prefixXor(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixXor[i + 1] = prefixXor[i] ^ nums[i];
        }

        std::vector<int> result;
        result.reserve(n - k + 1); 
        for (int i = 0; i <= n - k; ++i) {
            result.push_back(prefixXor[i + k] ^ prefixXor[i]);
        }

        return result;
    }
};