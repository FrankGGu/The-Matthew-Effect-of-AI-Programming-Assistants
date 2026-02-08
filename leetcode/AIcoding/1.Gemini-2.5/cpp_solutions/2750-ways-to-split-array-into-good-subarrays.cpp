#include <vector>
#include <numeric>

class Solution {
public:
    int waysToSplitArray(std::vector<int>& nums) {
        long long MOD = 1e9 + 7;
        std::vector<int> one_indices;

        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] == 1) {
                one_indices.push_back(i);
            }
        }

        if (one_indices.empty()) {
            return 0;
        }

        if (one_indices.size() == 1) {
            return 1;
        }

        long long ways = 1;
        for (int i = 0; i < one_indices.size() - 1; ++i) {
            long long gap = one_indices[i+1] - one_indices[i];
            ways = (ways * gap) % MOD;
        }

        return static_cast<int>(ways);
    }
};