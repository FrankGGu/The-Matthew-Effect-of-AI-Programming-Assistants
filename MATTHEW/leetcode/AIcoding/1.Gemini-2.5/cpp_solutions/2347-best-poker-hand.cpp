#include <vector>
#include <string>
#include <map>

class Solution {
public:
    std::string bestHand(std::vector<int>& ranks, std::vector<char>& suits) {
        bool isFlush = true;
        for (size_t i = 1; i < suits.size(); ++i) {
            if (suits[i] != suits[0]) {
                isFlush = false;
                break;
            }
        }
        if (isFlush) {
            return "Flush";
        }

        std::map<int, int> rankCounts;
        for (int rank : ranks) {
            rankCounts[rank]++;
        }

        int maxFreq = 0;
        for (auto const& pair : rankCounts) {
            if (pair.second > maxFreq) {
                maxFreq = pair.second;
            }
        }

        if (maxFreq >= 3) {
            return "Three of a Kind";
        } else if (maxFreq == 2) {
            return "Pair";
        } else {
            return "High Card";
        }
    }
};