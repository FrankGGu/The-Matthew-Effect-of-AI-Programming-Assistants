#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> sortEvenOdd(std::vector<int>& nums) {
        std::vector<int> even_indices;
        std::vector<int> odd_indices;

        for (int i = 0; i < nums.size(); ++i) {
            if (i % 2 == 0) {
                even_indices.push_back(nums[i]);
            } else {
                odd_indices.push_back(nums[i]);
            }
        }

        std::sort(even_indices.begin(), even_indices.end());
        std::sort(odd_indices.begin(), odd_indices.end(), std::greater<int>());

        std::vector<int> result;
        int even_idx = 0;
        int odd_idx = 0;

        for (int i = 0; i < nums.size(); ++i) {
            if (i % 2 == 0) {
                result.push_back(even_indices[even_idx++]);
            } else {
                result.push_back(odd_indices[odd_idx++]);
            }
        }

        return result;
    }
};