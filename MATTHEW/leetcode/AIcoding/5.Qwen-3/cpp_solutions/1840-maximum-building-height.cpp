#include <iostream>
#include <vector>
#include <algorithm>
#include <utility>

using namespace std;

class Solution {
public:
    long long maxHappyMinutes(vector<int>& red, vector<int>& blue, vector<vector<int>>& queries) {
        int n = red.size();
        vector<pair<int, int>> buildings;
        for (int i = 0; i < n; ++i) {
            buildings.push_back({red[i], blue[i]});
        }
        sort(buildings.begin(), buildings.end());

        vector<long long> prefix_red(n, 0), prefix_blue(n, 0);
        prefix_red[0] = buildings[0].first;
        prefix_blue[0] = buildings[0].second;
        for (int i = 1; i < n; ++i) {
            prefix_red[i] = prefix_red[i - 1] + buildings[i].first;
            prefix_blue[i] = prefix_blue[i - 1] + buildings[i].second;
        }

        long long result = 0;
        for (auto& q : queries) {
            int l = q[0], r = q[1];
            long long total_red = prefix_red[r] - (l > 0 ? prefix_red[l - 1] : 0);
            long long total_blue = prefix_blue[r] - (l > 0 ? prefix_blue[l - 1] : 0);
            result += max(total_red, total_blue);
        }
        return result;
    }
};