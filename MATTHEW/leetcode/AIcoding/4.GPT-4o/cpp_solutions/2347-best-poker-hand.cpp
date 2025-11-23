#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    std::string bestHand(std::vector<int>& ranks) {
        std::unordered_map<int, int> count;
        int maxCount = 0;
        for (int rank : ranks) {
            count[rank]++;
            maxCount = std::max(maxCount, count[rank]);
        }
        if (maxCount >= 3) return "Three of a Kind";
        if (maxCount == 2) return "One Pair";
        return "High Card";
    }
};