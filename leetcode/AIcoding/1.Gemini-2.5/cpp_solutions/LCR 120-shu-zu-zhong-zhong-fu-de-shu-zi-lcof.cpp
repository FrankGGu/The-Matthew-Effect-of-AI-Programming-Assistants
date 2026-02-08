#include <vector>
#include <unordered_set>
#include <algorithm>

class Solution {
public:
    std::vector<int> findDuplicates(std::vector<int>& nums) {
        std::unordered_set<int> seen;
        std::unordered_set<int> duplicates_set;

        for (int num : nums) {
            if (seen.count(num)) {
                duplicates_set.insert(num);
            } else {
                seen.insert(num);
            }
        }

        std::vector<int> result;
        result.reserve(duplicates_set.size());
        for (int dup : duplicates_set) {
            result.push_back(dup);
        }

        return result;
    }
};