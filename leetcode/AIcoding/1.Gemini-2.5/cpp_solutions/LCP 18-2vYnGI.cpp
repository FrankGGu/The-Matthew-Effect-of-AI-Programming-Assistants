#include <vector>
#include <algorithm>

class Solution {
public:
    int breakfastNumber(std::vector<int>& staple, std::vector<int>& drinks, int x) {
        std::sort(drinks.begin(), drinks.end());
        long long count = 0;
        const int MOD = 1000000007;

        for (int s : staple) {
            int max_drink_cost = x - s;
            if (max_drink_cost < 0) {
                continue; 
            }

            auto it = std::upper_bound(drinks.begin(), drinks.end(), max_drink_cost);
            long long num_valid_drinks = std::distance(drinks.begin(), it);
            count = (count + num_valid_drinks) % MOD;
        }

        return static_cast<int>(count);
    }
};