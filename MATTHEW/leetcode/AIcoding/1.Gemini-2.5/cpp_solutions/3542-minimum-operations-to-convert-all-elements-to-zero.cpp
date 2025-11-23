#include <vector>
#include <set>

class Solution {
public:
    int minimumOperations(std::vector<int>& nums) {
        std::set<int> distinct_positive_numbers;
        for (int num : nums) {
            if (num > 0) {
                distinct_positive_numbers.insert(num);
            }
        }
        return distinct_positive_numbers.size();
    }
};