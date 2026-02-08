#include <vector>
#include <queue>
#include <set>

using namespace std;

class Solution {
public:
    vector<vector<int>> getSkyline(vector<vector<int>>& buildings) {
        vector<pair<int, int>> events;
        for (auto& b : buildings) {
            events.push_back({b[0], -b[2]});
            events.push_back({b[1], b[2]});
        }
        sort(events.begin(), events.end());

        multiset<int> heights = {0};
        vector<vector<int>> result;
        int currentHeight = 0;

        for (auto& event : events) {
            int position = event.first;
            int height = event.second;

            if (height < 0) {
                heights.insert(-height);
            } else {
                heights.erase(heights.find(height));
            }

            int maxHeight = *heights.rbegin();
            if (maxHeight != currentHeight) {
                result.push_back({position, maxHeight});
                currentHeight = maxHeight;
            }
        }

        return result;
    }
};