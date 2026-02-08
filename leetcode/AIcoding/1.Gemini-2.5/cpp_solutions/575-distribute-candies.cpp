#include <unordered_set>
#include <algorithm>

class Solution {
public:
    int distributeCandies(std::vector<int>& candyType) {
        std::unordered_set<int> uniqueCandies(candyType.begin(), candyType.end());
        return std::min(uniqueCandies.size(), candyType.size() / 2);
    }
};