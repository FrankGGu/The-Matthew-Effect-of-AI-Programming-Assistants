#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<long long>> splitPainting(vector<vector<int>>& segments) {
        vector<pair<int, long long>> events;
        for (auto& seg : segments) {
            events.push_back({seg[0], seg[2]});
            events.push_back({seg[1], -seg[2]});
        }
        sort(events.begin(), events.end());

        vector<vector<long long>> result;
        long long current_color = 0;
        int start = events[0].first;
        for (int i = 0; i < events.size(); ++i) {
            if (i > 0 && events[i].first > events[i - 1].first) {
                if (current_color > 0) {
                    result.push_back({(long long)start, (long long)events[i].first, current_color});
                }
                start = events[i].first;
            }
            current_color += events[i].second;
        }

        return result;
    }
};