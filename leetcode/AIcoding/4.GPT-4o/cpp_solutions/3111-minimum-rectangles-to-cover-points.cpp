#include <vector>
#include <set>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minRectangles(vector<vector<int>>& points) {
        set<pair<int, int>> pointSet;
        for (const auto& point : points) {
            pointSet.insert({point[0], point[1]});
        }

        int count = 0;
        while (!pointSet.empty()) {
            auto it = pointSet.begin();
            int x1 = it->first, y1 = it->second;
            int x2 = x1, y2 = y1;

            for (auto jt = pointSet.begin(); jt != pointSet.end(); ) {
                if (jt->first >= x1 && jt->second >= y1) {
                    x2 = max(x2, jt->first);
                    y2 = max(y2, jt->second);
                    jt = pointSet.erase(jt);
                } else {
                    ++jt;
                }
            }
            count++;
        }
        return count;
    }
};