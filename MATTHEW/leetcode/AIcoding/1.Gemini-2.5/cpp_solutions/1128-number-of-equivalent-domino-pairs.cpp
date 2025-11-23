#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int numEquivDominoPairs(std::vector<std::vector<int>>& dominoes) {
        std::unordered_map<int, int> counts;
        int totalPairs = 0;

        for (const auto& domino : dominoes) {
            int val1 = domino[0];
            int val2 = domino[1];

            if (val1 > val2) {
                std::swap(val1, val2);
            }

            int key = val1 * 10 + val2;
            counts[key]++;
        }

        for (const auto& pair : counts) {
            int count = pair.second;
            if (count >= 2) {
                totalPairs += (count * (count - 1)) / 2;
            }
        }

        return totalPairs;
    }
};