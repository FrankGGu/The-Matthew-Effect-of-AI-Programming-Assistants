#include <vector>
#include <algorithm>

class Solution {
public:
    int maxIceCream(std::vector<int>& costs, int coins) {
        std::sort(costs.begin(), costs.end());
        int count = 0;
        for (int cost : costs) {
            if (coins >= cost) {
                coins -= cost;
                count++;
            } else {
                break;
            }
        }
        return count;
    }
};