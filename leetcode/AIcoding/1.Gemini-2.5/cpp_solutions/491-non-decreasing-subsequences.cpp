#include <vector>
#include <set>
#include <algorithm>

class Solution {
public:
    std::set<std::vector<int>> result_set;
    std::vector<int> current_path;
    std::vector<int> nums_vec;

    void backtrack(int index) {
        if (current_path.size() >= 2) {
            result_set.insert(current_path);
        }

        for (int i = index; i < nums_vec.size(); ++i) {
            if (current_path.empty() || nums_vec[i] >= current_path.back()) {
                current_path.push_back(nums_vec[i]);
                backtrack(i + 1);
                current_path.pop_back();
            }
        }
    }

    std::vector<std::vector<int>> findSubsequences(std::vector<int>& nums) {
        nums_vec = nums;
        backtrack(0);

        std::vector<std::vector<int>> final_result;
        for (const auto& seq : result_set) {
            final_result.push_back(seq);
        }
        return final_result;
    }
};