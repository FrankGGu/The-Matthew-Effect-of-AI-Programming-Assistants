#include <vector>
#include <unordered_map>

class Solution {
public:
    std::vector<int> findLonely(std::vector<int>& nums) {
        std::unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }
        std::vector<int> result;
        for (const auto& [num, cnt] : count) {
            if (cnt == 1 && count.find(num - 1) == count.end() && count.find(num + 1) == count.end()) {
                result.push_back(num);
            }
        }
        return result;
    }
};