#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    int maxCoins(std::vector<int>& piles) {
        std::sort(piles.begin(), piles.end());

        int my_total_coins = 0;
        int n = piles.size() / 3;

        int left = 0;
        int right = piles.size() - 1;

        for (int i = 0; i < n; ++i) {
            // Alice takes piles[right] (largest)
            // I take piles[right - 1] (second largest)
            my_total_coins += piles[right - 1];
            // Bob takes piles[left] (smallest)

            // Move pointers for the next round
            left++;
            right -= 2;
        }

        return my_total_coins;
    }
};