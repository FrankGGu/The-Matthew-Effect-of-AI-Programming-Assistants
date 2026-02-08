#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximizeActiveSections(vector<int>& start, vector<int>& end) {
        int n = start.size();
        vector<pair<int, int>> events;
        for (int i = 0; i < n; ++i) {
            events.push_back({start[i], 1});
            events.push_back({end[i], -1});
        }
        sort(events.begin(), events.end());

        int active = 0;
        int max_active = 0;
        for (auto& event : events) {
            active += event.second;
            max_active = max(max_active, active);
        }

        return max_active;
    }
};