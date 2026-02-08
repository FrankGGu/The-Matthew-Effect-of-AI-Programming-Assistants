#include <vector>
#include <unordered_map>
#include <random>

class Solution {
private:
    std::unordered_map<int, std::vector<int>> indices_map;

public:
    Solution(std::vector<int>& nums) {
        for (int i = 0; i < nums.size(); ++i) {
            indices_map[nums[i]].push_back(i);
        }
    }

    int pick(int target) {
        const std::vector<int>& candidates = indices_map.at(target);
        int random_index = rand() % candidates.size();
        return candidates[random_index];
    }
};