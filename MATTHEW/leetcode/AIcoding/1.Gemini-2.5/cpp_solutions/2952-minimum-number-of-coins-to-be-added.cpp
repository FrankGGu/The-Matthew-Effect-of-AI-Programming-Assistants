#include <vector>
#include <algorithm>

class Solution {
public:
    int minimumAddedCoins(std::vector<int>& coins, int target) {
        std::sort(coins.begin(), coins.end());

        long long maxReachable = 0;
        int coinsAdded = 0;
        int index = 0;

        while (maxReachable < target) {
            if (index < coins.size() && coins[index] <= maxReachable + 1) {
                maxReachable += coins[index];
                index++;
            } else {
                coinsAdded++;
                maxReachable += (maxReachable + 1);
            }
        }

        return coinsAdded;
    }
};