#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int getNumberOfBacklogOperations(vector<int>& inventory, int k) {
        int n = inventory.size();
        vector<pair<int, int>> towers;
        for (int i = 0; i < n; ++i) {
            towers.push_back({inventory[i], i});
        }
        sort(towers.begin(), towers.end());

        int res = 0;
        int i = 0;
        while (k > 0 && i < n) {
            int height = towers[i].first;
            int index = towers[i].second;
            int nextHeight = (i + 1 < n) ? towers[i + 1].first : 0;
            int count = 1;
            while (i + 1 < n && towers[i + 1].first == height) {
                ++i;
                ++count;
            }
            int diff = height - nextHeight;
            int ops = diff * count;
            if (ops <= k) {
                res += ops;
                k -= ops;
                ++i;
            } else {
                int full = k / count;
                res += full * count;
                k -= full * count;
                if (k > 0) {
                    res += 1;
                    k--;
                }
                break;
            }
        }
        return res;
    }
};