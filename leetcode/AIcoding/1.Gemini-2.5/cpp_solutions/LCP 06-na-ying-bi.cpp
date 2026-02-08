#include <vector>

class Solution {
public:
    int minCoin(std::vector<int>& coins) {
        int totalTakenCoins = 0;
        for (int count : coins) {
            totalTakenCoins += (count + 1) / 2;
        }
        return totalTakenCoins;
    }
};