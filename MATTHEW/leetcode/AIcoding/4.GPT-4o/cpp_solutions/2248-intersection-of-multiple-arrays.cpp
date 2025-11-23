#include <vector>
#include <unordered_map>
#include <algorithm>

std::vector<int> intersection(std::vector<std::vector<int>>& nums) {
    std::unordered_map<int, int> count;
    int n = nums.size();

    for (const auto& vec : nums) {
        for (int num : vec) {
            count[num]++;
        }
    }

    std::vector<int> result;
    for (const auto& [key, val] : count) {
        if (val == n) {
            result.push_back(key);
        }
    }

    std::sort(result.begin(), result.end());
    return result;
}