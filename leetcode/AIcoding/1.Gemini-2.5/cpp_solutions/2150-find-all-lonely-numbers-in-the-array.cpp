#include <vector>
#include <unordered_map>

class Solution {
public:
    std::vector<int> findLonely(std::vector<int>& nums) {
        std::unordered_map<int, int> counts;
        for (int num : nums) {
            counts[num]++;
        }

        std::vector<int> result;
        for (auto const& [num, count] : counts) {
            if (count == 1) {
                if (counts.find(num - 1) == counts.end() && counts.find(num + 1) == counts.end()) {
                    result.push_back(num);
                }
            }
        }
        return result;
    }
};