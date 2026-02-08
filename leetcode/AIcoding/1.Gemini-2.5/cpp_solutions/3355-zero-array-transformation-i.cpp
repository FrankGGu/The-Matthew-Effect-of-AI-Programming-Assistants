#include <vector>
#include <set>
#include <algorithm>

class Solution {
public:
    int minimumOperations(std::vector<int>& nums) {
        std::set<int> distinct_positive_elements;
        for (int num : nums) {
            if (num > 0) {
                distinct_positive_elements.insert(num);
            }
        }
        return distinct_positive_elements.size();
    }
};