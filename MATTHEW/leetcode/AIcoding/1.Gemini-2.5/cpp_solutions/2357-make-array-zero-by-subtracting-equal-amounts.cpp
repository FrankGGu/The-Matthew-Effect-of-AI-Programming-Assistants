#include <vector>
#include <set>
#include <algorithm>

class Solution {
public:
    int minimumOperations(std::vector<int>& nums) {
        std::set<int> unique_positive_numbers;
        for (int num : nums) {
            if (num > 0) {
                unique_positive_numbers.insert(num);
            }
        }
        return unique_positive_numbers.size();
    }
};