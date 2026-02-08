#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxSpending(int64_t* price, int64_t* cost, int64_t n) {
        vector<pair<int64_t, int64_t>> items;
        for (int64_t i = 0; i < n; ++i) {
            items.push_back({price[i], cost[i]});
        }
        sort(items.begin(), items.end());
        long long total = 0;
        for (int64_t i = 0; i < n; ++i) {
            total += static_cast<long long>(items[i].first) * items[i].second;
        }
        return total;
    }
};