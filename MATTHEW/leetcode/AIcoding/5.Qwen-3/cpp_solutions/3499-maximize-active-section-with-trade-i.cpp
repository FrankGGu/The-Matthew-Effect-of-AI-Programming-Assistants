#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxActiveSections(vector<int>& trade, vector<int>& active) {
        int n = trade.size();
        vector<pair<int, int>> events;

        for (int i = 0; i < n; ++i) {
            events.push_back({trade[i], active[i]});
        }

        sort(events.begin(), events.end());

        int result = 0;
        int currentActive = 0;
        int i = 0;

        while (i < n) {
            int j = i;
            while (j < n && events[j].first == events[i].first) {
                ++j;
            }

            for (int k = i; k < j; ++k) {
                currentActive += events[k].second;
            }

            result = max(result, currentActive);

            for (int k = i; k < j; ++k) {
                currentActive -= events[k].second;
            }

            i = j;
        }

        return result;
    }
};