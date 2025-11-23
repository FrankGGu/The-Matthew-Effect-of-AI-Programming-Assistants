#include <vector>
#include <unordered_set>

class Solution {
public:
    std::vector<int> twoSum(std::vector<int>& price, int target) {
        std::unordered_set<int> seen;
        for (int p : price) {
            int complement = target - p;
            if (seen.count(complement)) {
                return {complement, p};
            }
            seen.insert(p);
        }
        return {};
    }
};