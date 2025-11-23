#include <vector>
#include <algorithm>
#include <utility>

class Solution {
public:
    std::vector<int> maxSubsequence(std::vector<int>& nums, int k) {
        std::vector<std::pair<int, int>> indexed_nums;
        for (int i = 0; i < nums.size(); ++i) {
            indexed_nums.push_back({nums[i], i});
        }

        std::sort(indexed_nums.begin(), indexed_nums.end(), [](const std::pair<int, int>& a, const std::pair<int, int>& b) {
            return a.first > b.first;
        });

        std::vector<std::pair<int, int>> top_k_elements;
        for (int i = 0; i < k; ++i) {
            top_k_elements.push_back(indexed_nums[i]);
        }

        std::sort(top_k_elements.begin(), top_k_elements.end(), [](const std::pair<int, int>& a, const std::pair<int, int>& b) {
            return a.second < b.second;
        });

        std::vector<int> result;
        for (const auto& p : top_k_elements) {
            result.push_back(p.first);
        }

        return result;
    }
};