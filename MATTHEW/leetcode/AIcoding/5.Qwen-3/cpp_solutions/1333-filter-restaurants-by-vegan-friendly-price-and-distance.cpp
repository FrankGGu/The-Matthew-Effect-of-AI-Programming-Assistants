#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> filterRestaurants(vector<vector<int>>& restaurants, int veganFriendly, int maxPrice, int maxDistance) {
        vector<vector<int>> result;
        for (const auto& r : restaurants) {
            int id = r[0];
            int rating = r[1];
            int vegan = r[2];
            int price = r[3];
            int distance = r[4];
            if (veganFriendly && vegan != 1) continue;
            if (price > maxPrice) continue;
            if (distance > maxDistance) continue;
            result.push_back({id, rating});
        }
        sort(result.begin(), result.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] > b[1] || (a[1] == b[1] && a[0] > b[0]);
        });
        return result;
    }
};