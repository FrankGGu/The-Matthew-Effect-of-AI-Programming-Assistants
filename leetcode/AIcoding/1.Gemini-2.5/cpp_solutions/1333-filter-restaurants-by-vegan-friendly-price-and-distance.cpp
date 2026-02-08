#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> filterRestaurants(std::vector<std::vector<int>>& restaurants, int veganFriendly, int maxPrice, int maxDistance) {
        std::vector<std::vector<int>> filteredRestaurants;

        for (const auto& r : restaurants) {
            if ((veganFriendly == 0 || r[2] == 1) && r[3] <= maxPrice && r[4] <= maxDistance) {
                filteredRestaurants.push_back(r);
            }
        }

        std::sort(filteredRestaurants.begin(), filteredRestaurants.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            if (a[1] != b[1]) {
                return a[1] > b[1];
            }
            return a[0] > b[0];
        });

        std::vector<int> result;
        result.reserve(filteredRestaurants.size());
        for (const auto& r : filteredRestaurants) {
            result.push_back(r[0]);
        }

        return result;
    }
};