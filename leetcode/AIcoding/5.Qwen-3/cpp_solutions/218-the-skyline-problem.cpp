#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> getSkyline(vector<vector<int>>& buildings) {
        vector<vector<int>> result;
        if (buildings.empty()) return result;

        vector<pair<int, int>> points;
        for (const auto& b : buildings) {
            points.emplace_back(b[0], -b[2]);
            points.emplace_back(b[1], b[2]);
        }

        sort(points.begin(), points.end());

        priority_queue<int> maxHeap;
        maxHeap.push(0);
        int prevHeight = 0;

        for (size_t i = 0; i < points.size(); ++i) {
            int x = points[i].first;
            int h = points[i].second;

            if (h < 0) {
                maxHeap.push(-h);
            } else {
                                                            }

            while (!maxHeap.empty() && maxHeap.top() == 0) {
                maxHeap.pop();
            }

            int currentHeight = maxHeap.empty() ? 0 : maxHeap.top();

            if (currentHeight != prevHeight) {
                result.push_back({x, currentHeight});
                prevHeight = currentHeight;
            }

                        while (i + 1 < points.size() && points[i + 1].first == x) {
                ++i;
            }
        }

        return result;
    }
};