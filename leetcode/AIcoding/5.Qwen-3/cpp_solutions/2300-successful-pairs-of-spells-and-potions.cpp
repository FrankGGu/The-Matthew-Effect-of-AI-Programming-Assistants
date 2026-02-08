#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> successfulPairs(std::vector<int>& spells, std::vector<int>& potions, long long success) {
        int n = spells.size();
        int m = potions.size();
        std::vector<int> result(n);
        std::sort(potions.begin(), potions.end());
        for (int i = 0; i < n; ++i) {
            long long target = (success + spells[i] - 1) / spells[i];
            auto it = std::lower_bound(potions.begin(), potions.end(), target);
            result[i] = m - (it - potions.begin());
        }
        return result;
    }
};