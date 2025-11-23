#include <vector>
#include <map>
#include <algorithm> // For std::min

class Solution {
public:
    std::map<std::vector<int>, int> memo;
    int num_items;

    int solve(const std::vector<int>& current_needs, const std::vector<int>& price, const std::vector<std::vector<int>>& special) {
        if (memo.count(current_needs)) {
            return memo[current_needs];
        }

        int min_cost = 0;
        for (int i = 0; i < num_items; ++i) {
            min_cost += current_needs[i] * price[i];
        }

        for (const auto& offer : special) {
            std::vector<int> next_needs = current_needs;
            bool can_apply = true;

            for (int i = 0; i < num_items; ++i) {
                if (offer[i] > next_needs[i]) {
                    can_apply = false;
                    break;
                }
                next_needs[i] -= offer[i];
            }

            if (can_apply) {
                min_cost = std::min(min_cost, offer[num_items] + solve(next_needs, price, special));
            }
        }

        return memo[current_needs] = min_cost;
    }

    int shoppingOffers(std::vector<int>& price, std::vector<std::vector<int>>& special, std::vector<int>& needs) {
        num_items = price.size();
        return solve(needs, price, special);
    }
};