#include <vector>
#include <tuple>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> filterRestaurants(vector<vector<int>>& restaurants, int veganFriendly, int maxPrice, int maxDistance) {
        vector<vector<int>> result;
        for (const auto& restaurant : restaurants) {
            if ((veganFriendly == 0 || restaurant[2] == 1) && 
                restaurant[3] <= maxPrice && 
                restaurant[4] <= maxDistance) {
                result.push_back(restaurant);
            }
        }
        sort(result.begin(), result.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] > b[1] || (a[1] == b[1] && a[0] > b[0]);
        });
        return result;
    }
};