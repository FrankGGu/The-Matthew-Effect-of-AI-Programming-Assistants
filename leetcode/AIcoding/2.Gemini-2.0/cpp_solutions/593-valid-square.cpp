#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    bool validSquare(vector<int>& p1, vector<int>& p2, vector<int>& p3, vector<int>& p4) {
        vector<vector<int>> points = {p1, p2, p3, p4};
        sort(points.begin(), points.end());

        auto distSq = [](vector<int>& p1, vector<int>& p2) {
            return (p1[0] - p2[0]) * (p1[0] - p2[0]) + (p1[1] - p2[1]) * (p1[1] - p2[1]);
        };

        vector<int> distances;
        distances.push_back(distSq(points[0], points[1]));
        distances.push_back(distSq(points[0], points[2]));
        distances.push_back(distSq(points[0], points[3]));
        distances.push_back(distSq(points[1], points[2]));
        distances.push_back(distSq(points[1], points[3]));
        distances.push_back(distSq(points[2], points[3]));

        sort(distances.begin(), distances.end());

        if (distances[0] == 0) return false;

        return (distances[0] == distances[1] && distances[1] == distances[2] && distances[2] == distances[3] &&
                distances[4] == distances[5] && distances[4] == 2 * distances[0]);
    }
};