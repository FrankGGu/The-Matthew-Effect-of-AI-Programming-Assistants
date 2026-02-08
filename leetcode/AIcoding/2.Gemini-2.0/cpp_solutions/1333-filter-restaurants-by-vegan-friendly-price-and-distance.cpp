#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> filterRestaurants(vector<vector<int>>& restaurants, int veganFriendly, int maxPrice, int maxDistance) {
        vector<pair<int, int>> filteredRestaurants;
        for (auto& restaurant : restaurants) {
            if ((veganFriendly == 0 || restaurant[2] >= veganFriendly) &&
                restaurant[3] <= maxPrice &&
                restaurant[4] <= maxDistance) {
                filteredRestaurants.push_back({restaurant[0], restaurant[1]});
            }
        }

        sort(filteredRestaurants.begin(), filteredRestaurants.end(), [](const auto& a, const auto& b) {
            if (a.second != b.second) {
                return a.second > b.second;
            } else {
                return a.first > b.first;
            }
        });

        vector<int> result;
        for (auto& restaurant : filteredRestaurants) {
            result.push_back(restaurant.first);
        }

        return result;
    }
};