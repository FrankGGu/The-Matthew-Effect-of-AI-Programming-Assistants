#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int rectangleArea(vector<vector<int>>& rectangles) {
        const int MOD = 1e9 + 7;
        vector<long long> xs;
        vector<vector<long long>> events;

        for (const auto& rect : rectangles) {
            xs.push_back(rect[0]);
            xs.push_back(rect[2]);
            events.push_back({(long long)rect[0], 0, rect[1], rect[3]});
            events.push_back({(long long)rect[2], 1, rect[1], rect[3]});
        }

        sort(xs.begin(), xs.end());
        sort(events.begin(), events.end());

        long long area = 0;
        int prevX = -1;
        int prevY = -1;
        int prevHeight = 0;

        for (const auto& event : events) {
            long long x = event[0];
            int type = event[1];
            int y1 = event[2];
            int y2 = event[3];

            if (prevX != -1 && x > prevX && prevHeight > 0) {
                area += (x - prevX) * prevHeight;
                area %= MOD;
            }

            if (type == 0) {
                prevHeight += y2 - y1;
            } else {
                prevHeight -= y2 - y1;
            }

            prevX = x;
        }

        return area % MOD;
    }
};