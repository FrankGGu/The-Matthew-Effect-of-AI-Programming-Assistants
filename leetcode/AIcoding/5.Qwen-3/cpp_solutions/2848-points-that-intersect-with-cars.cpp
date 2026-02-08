#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numberOfPoints(vector<vector<int>>& lanes) {
        vector<int> events;
        for (const auto& lane : lanes) {
            events.push_back(lane[0]);
            events.push_back(lane[1] + 1);
        }
        sort(events.begin(), events.end());
        int result = 0;
        int prev = -1;
        for (int i = 0; i < events.size(); i += 2) {
            int start = events[i];
            int end = events[i + 1];
            if (prev < end) {
                result += max(0, end - max(prev, start));
                prev = end;
            }
        }
        return result;
    }
};