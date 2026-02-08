#include <vector>
#include <set>

class Solution {
public:
    int minimumOperations(std::vector<int>& nums) {
        std::set<int> distinctPositiveNumbers;
        for (int num : nums) {
            if (num > 0) {
                distinctPositiveNumbers.insert(num);
            }
        }
        return distinctPositiveNumbers.size();
    }
};