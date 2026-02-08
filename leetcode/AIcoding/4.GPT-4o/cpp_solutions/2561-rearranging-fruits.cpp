#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> rearrangeFruits(std::vector<int>& fruits) {
        std::sort(fruits.begin(), fruits.end());
        return fruits;
    }
};