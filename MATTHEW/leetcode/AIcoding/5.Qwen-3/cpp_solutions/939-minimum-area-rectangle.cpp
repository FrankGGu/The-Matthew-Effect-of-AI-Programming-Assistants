#include <iostream>
#include <vector>
#include <unordered_map>
#include <climits>

using namespace std;

class Solution {
public:
    int minAreaRect(vector<vector<int>>& points) {
        unordered_map<int, vector<int>> pointMap;
        for (const auto& p : points) {
            pointMap[p[0]].push_back(p[1]);
        }

        for (auto& [x, ys] : pointMap) {
            sort(ys.begin(), ys.end());
        }

        int minArea = INT_MAX;

        for (auto it1 = pointMap.begin(); it1 != pointMap.end(); ++it1) {
            int x1 = it1->first;
            vector<int> y1s = it1->second;
            for (auto it2 = next(it1); it2 != pointMap.end(); ++it2) {
                int x2 = it2->first;
                vector<int> y2s = it2->second;
                int i = 0, j = 0;
                while (i < y1s.size() && j < y2s.size()) {
                    if (y1s[i] == y2s[j]) {
                        int width = x2 - x1;
                        int height = y1s[i];
                        if (i > 0 && j > 0 && y1s[i-1] == y2s[j-1]) {
                            minArea = min(minArea, width * (y1s[i] - y1s[i-1]));
                        }
                        ++i;
                        ++j;
                    } else if (y1s[i] < y2s[j]) {
                        ++i;
                    } else {
                        ++j;
                    }
                }
            }
        }

        return minArea == INT_MAX ? 0 : minArea;
    }
};