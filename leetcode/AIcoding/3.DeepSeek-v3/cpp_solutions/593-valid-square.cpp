#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool validSquare(vector<int>& p1, vector<int>& p2, vector<int>& p3, vector<int>& p4) {
        vector<vector<int>> points = {p1, p2, p3, p4};
        vector<int> distances;

        for (int i = 0; i < 4; ++i) {
            for (int j = i + 1; j < 4; ++j) {
                int dx = points[i][0] - points[j][0];
                int dy = points[i][1] - points[j][1];
                distances.push_back(dx * dx + dy * dy);
            }
        }

        sort(distances.begin(), distances.end());

        if (distances[0] == 0) return false;

        return distances[0] == distances[1] && 
               distances[0] == distances[2] && 
               distances[0] == distances[3] && 
               distances[4] == distances[5] && 
               distances[4] == 2 * distances[0];
    }
};