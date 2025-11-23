#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> describePainting(vector<vector<int>>& painting) {
        map<int, int> xCoordinates;
        map<int, map<int, int>> colorMap;

        for (const auto& p : painting) {
            int x1 = p[0], y1 = p[1], x2 = p[2], y2 = p[3];
            xCoordinates[x1] = 0;
            xCoordinates[x2] = 0;
            colorMap[y1][x1]++;
            colorMap[y2][x1]--;
            colorMap[y1][x2]--;
            colorMap[y2][x2]++;
        }

        vector<vector<int>> result;
        vector<int> xList(xCoordinates.begin(), xCoordinates.end());
        sort(xList.begin(), xList.end());

        map<int, int> currentColors;
        for (int i = 0; i < xList.size() - 1; ++i) {
            int xStart = xList[i];
            int xEnd = xList[i + 1];

            for (auto& [y, cnt] : colorMap) {
                currentColors[y] += cnt;
            }

            vector<int> colors;
            for (auto& [y, cnt] : currentColors) {
                if (cnt > 0) {
                    colors.push_back(y);
                }
            }

            if (!colors.empty()) {
                result.push_back({xStart, xEnd, colors[0]});
                for (int j = 1; j < colors.size(); ++j) {
                    result.back().push_back(colors[j]);
                }
            }
        }

        return result;
    }
};