class Solution {
public:
    vector<int> filterRestaurants(vector<vector<int>>& restaurants, int veganFriendly, int maxPrice, int maxDistance) {
        vector<pair<int, int>> filtered;
        for (const auto& r : restaurants) {
            if ((veganFriendly == 0 || r[2] == veganFriendly) && r[3] <= maxPrice && r[4] <= maxDistance) {
                filtered.emplace_back(r[1], r[0]);
            }
        }
        sort(filtered.begin(), filtered.end(), [](const pair<int, int>& a, const pair<int, int>& b) {
            return a.first == b.first ? a.second > b.second : a.first > b.first;
        });
        vector<int> result;
        for (const auto& p : filtered) {
            result.push_back(p.second);
        }
        return result;
    }
};