#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    bool validSquare(int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4) {
        vector<int> dists;
        auto getDist = [&](int x1, int y1, int x2, int y2) {
            return (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
        };
        dists.push_back(getDist(x1, y1, x2, y2));
        dists.push_back(getDist(x1, y1, x3, y3));
        dists.push_back(getDist(x1, y1, x4, y4));
        dists.push_back(getDist(x2, y2, x3, y3));
        dists.push_back(getDist(x2, y2, x4, y4));
        dists.push_back(getDist(x3, y3, x4, y4));

        sort(dists.begin(), dists.end());

        return dists[0] == dists[1] && dists[1] == dists[2] && dists[2] == dists[3] && dists[4] == dists[5] && dists[0] != 0;
    }
};