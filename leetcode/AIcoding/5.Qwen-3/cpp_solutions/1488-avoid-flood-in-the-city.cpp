#include <iostream>
#include <vector>
#include <map>
#include <set>

using namespace std;

class Solution {
public:
    vector<int> avoidFlood(vector<int>& rains) {
        int n = rains.size();
        vector<int> result(n, 1);
        map<int, int> lakeToIndex;
        set<int> dryDays;

        for (int i = 0; i < n; ++i) {
            if (rains[i] == -1) {
                dryDays.insert(i);
                result[i] = -1;
            } else {
                int lake = rains[i];
                if (lakeToIndex.find(lake) != lakeToIndex.end()) {
                    auto it = dryDays.lower_bound(lakeToIndex[lake]);
                    if (it != dryDays.end()) {
                        result[*it] = lake;
                        dryDays.erase(it);
                    } else {
                        return {};
                    }
                }
                lakeToIndex[lake] = i;
                result[i] = 1;
            }
        }

        return result;
    }
};