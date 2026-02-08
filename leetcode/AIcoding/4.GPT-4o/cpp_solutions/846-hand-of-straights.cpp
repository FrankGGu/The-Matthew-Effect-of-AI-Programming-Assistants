#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    bool isNStraightHand(std::vector<int>& hand, int W) {
        if (hand.size() % W != 0) return false;
        std::unordered_map<int, int> count;
        for (int card : hand) count[card]++;
        std::sort(hand.begin(), hand.end());

        for (int card : hand) {
            if (count[card] == 0) continue;
            for (int i = 0; i < W; ++i) {
                if (count[card + i] == 0) return false;
                count[card + i]--;
            }
        }
        return true;
    }
};