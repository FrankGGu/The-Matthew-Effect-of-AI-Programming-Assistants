#include <vector>
#include <unordered_map>
#include <set>
#include <climits>

using namespace std;

class Solution {
public:
    int minAreaRect(vector<vector<int>>& points) {
        unordered_map<int, set<int>> pointSet;
        for (const auto& point : points) {
            pointSet[point[0]].insert(point[1]);
        }

        int minArea = INT_MAX;
        for (const auto& point1 : points) {
            for (const auto& point2 : points) {
                if (point1[0] < point2[0] && point1[1] < point2[1]) {
                    if (pointSet[point1[0]].count(point2[1]) && pointSet[point2[0]].count(point1[1])) {
                        int area = (point2[0] - point1[0]) * (point2[1] - point1[1]);
                        minArea = min(minArea, area);
                    }
                }
            }
        }

        return minArea == INT_MAX ? 0 : minArea;
    }
};