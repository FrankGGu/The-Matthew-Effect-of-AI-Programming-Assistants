#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> successfulPairs(std::vector<int>& spells, std::vector<int>& potions, long long success) {
        std::sort(potions.begin(), potions.end());
        std::vector<int> result;
        result.reserve(spells.size());
        int m = potions.size();

        for (int spell : spells) {
            long long min_potion = (success + spell - 1) / spell;
            auto it = std::lower_bound(potions.begin(), potions.end(), min_potion);
            result.push_back(m - (it - potions.begin()));
        }

        return result;
    }
};