#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> result;
    map<int, int> heightMap;

    vector<vector<int>> getSkyline(vector<vector<int>>& buildings) {
        vector<pair<int, int>> events;
        for (int i = 0; i < buildings.size(); ++i) {
            int left = buildings[i][0];
            int right = buildings[i][1];
            int height = buildings[i][2];
            events.push_back({left, height});
            events.push_back({right, -height});
        }

        sort(events.begin(), events.end());

        vector<vector<int>> res;
        int prevHeight = 0;
        int currentHeight = 0;

        for (int i = 0; i < events.size(); ++i) {
            int pos = events[i].first;
            int h = events[i].second;

            if (h > 0) {
                currentHeight = max(currentHeight, h);
            } else {
                currentHeight = max(currentHeight - abs(h), 0);
            }

            if (currentHeight != prevHeight) {
                res.push_back({pos, currentHeight});
                prevHeight = currentHeight;
            }
        }

        return res;
    }

    vector<vector<int>> fallingSquares(vector<vector<int>>& positions) {
        vector<vector<int>> res;
        map<int, int> intervals;
        vector<int> starts;
        vector<int> ends;

        for (auto& pos : positions) {
            int left = pos[0];
            int right = pos[1];
            int height = pos[2];

            int newHeight = height;
            for (auto it = intervals.begin(); it != intervals.end(); ++it) {
                int start = it->first;
                int end = it->second;
                if (start < right && end > left) {
                    newHeight = max(newHeight, it->second + height);
                }
            }

            intervals[left] = newHeight;
            intervals[right] = 0;

            res.push_back({left, right, newHeight});
        }

        return res;
    }
};