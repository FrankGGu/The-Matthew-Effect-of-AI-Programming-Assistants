#include <iostream>
#include <vector>
#include <unordered_map>
#include <cmath>
#include <limits>

using namespace std;

class Solution {
public:
    int minAreaRect(vector<vector<int>>& points) {
        unordered_map<int, unordered_set<int>> pointMap;
        for (const auto& p : points) {
            pointMap[p[0]].insert(p[1]);
        }

        int minArea = numeric_limits<int>::max();

        for (auto it1 = pointMap.begin(); it1 != pointMap.end(); ++it1) {
            for (auto it2 = next(it1); it2 != pointMap.end(); ++it2) {
                const auto& x1 = it1->first;
                const auto& x2 = it2->first;
                const auto& ySet1 = it1->second;
                const auto& ySet2 = it2->second;

                vector<int> commonY;
                set_intersection(ySet1.begin(), ySet1.end(), ySet2.begin(), ySet2.end(), back_inserter(commonY));

                if (commonY.size() >= 2) {
                    for (size_t i = 0; i < commonY.size(); ++i) {
                        for (size_t j = i + 1; j < commonY.size(); ++j) {
                            int y1 = commonY[i];
                            int y2 = commonY[j];
                            int width = abs(x2 - x1);
                            int height = abs(y2 - y1);
                            minArea = min(minArea, width * height);
                        }
                    }
                }
            }
        }

        return minArea == numeric_limits<int>::max() ? 0 : minArea;
    }
};