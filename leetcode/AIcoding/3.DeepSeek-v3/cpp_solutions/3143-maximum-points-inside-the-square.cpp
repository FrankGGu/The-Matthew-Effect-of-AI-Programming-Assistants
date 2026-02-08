#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxPointsInsideSquare(vector<vector<int>>& points, string s) {
        unordered_map<char, vector<int>> tagToDists;
        for (int i = 0; i < points.size(); ++i) {
            int x = points[i][0];
            int y = points[i][1];
            int dist = max(abs(x), abs(y));
            tagToDists[s[i]].push_back(dist);
        }

        vector<int> criticalDists;
        for (auto& [tag, dists] : tagToDists) {
            if (dists.size() >= 2) {
                sort(dists.begin(), dists.end());
                criticalDists.push_back(dists[1]);
            }
        }

        if (criticalDists.empty()) {
            return points.size();
        }

        int minCritical = *min_element(criticalDists.begin(), criticalDists.end());
        int count = 0;
        for (auto& point : points) {
            int x = point[0];
            int y = point[1];
            int dist = max(abs(x), abs(y));
            if (dist < minCritical) {
                ++count;
            }
        }
        return count;
    }
};