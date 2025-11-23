#include <vector>
#include <unordered_set>
#include <algorithm>

class Solution {
public:
    int findMaxK(std::vector<int>& nums) {
        std::unordered_set<int> seen_numbers;
        for (int num : nums) {
            seen_numbers.insert(num);
        }

        int max_k = -1;

        for (int num : nums) {
            if (num > 0) {
                if (seen_numbers.count(-num)) {
                    max_k = std::max(max_k, num);
                }
            }
        }

        return max_k;
    }
};