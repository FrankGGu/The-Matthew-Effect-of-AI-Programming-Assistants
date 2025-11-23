#include <vector>
#include <set>
#include <algorithm>

class Solution {
public:
    std::vector<int> relocateMarbles(std::vector<int>& nums, std::vector<int>& moveFrom, std::vector<int>& moveTo) {
        std::set<int> positions(nums.begin(), nums.end());

        for (size_t i = 0; i < moveFrom.size(); ++i) {
            if (positions.count(moveFrom[i])) {
                positions.erase(moveFrom[i]);
                positions.insert(moveTo[i]);
            }
        }

        std::vector<int> result(positions.begin(), positions.end());
        return result;
    }
};