#include <vector>
#include <unordered_map>
#include <algorithm> // For std::min

class Solution {
public:
    int maxDistinctElements(std::vector<int>& nums, int k) {
        std::unordered_map<int, int> counts;
        for (int x : nums) {
            counts[x]++;
        }

        int distinct_count = 0;
        int excess_count = 0;

        for (auto const& pair : counts) {
            distinct_count++;
            if (pair.second > 1) {
                excess_count += (pair.second - 1);
            }
        }

        int new_distinct_elements_from_ops = std::min(k, excess_count);

        return distinct_count + new_distinct_elements_from_ops;
    }
};