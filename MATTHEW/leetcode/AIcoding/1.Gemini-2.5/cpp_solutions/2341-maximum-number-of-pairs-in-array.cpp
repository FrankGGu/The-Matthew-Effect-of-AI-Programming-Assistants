#include <vector>
#include <numeric> // For std::iota if needed, but not for this problem
#include <map> // Can use std::map or std::unordered_map, or an array for frequency counting

class Solution {
public:
    std::vector<int> numberOfPairs(std::vector<int>& nums) {
        std::map<int, int> counts;
        for (int num : nums) {
            counts[num]++;
        }

        int pairs = 0;
        int leftovers = 0;

        for (auto const& [num, count] : counts) {
            pairs += count / 2;
            leftovers += count % 2;
        }

        return {pairs, leftovers};
    }
};