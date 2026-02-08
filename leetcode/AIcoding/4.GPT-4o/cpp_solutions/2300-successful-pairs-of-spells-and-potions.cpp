#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> successfulPairs(std::vector<int>& spells, std::vector<int>& potions, long long success) {
        std::vector<int> result(spells.size());
        std::sort(potions.begin(), potions.end());

        for (int i = 0; i < spells.size(); i++) {
            long long required = (success + spells[i] - 1) / spells[i];
            result[i] = potions.end() - std::lower_bound(potions.begin(), potions.end(), required);
        }

        return result;
    }
};