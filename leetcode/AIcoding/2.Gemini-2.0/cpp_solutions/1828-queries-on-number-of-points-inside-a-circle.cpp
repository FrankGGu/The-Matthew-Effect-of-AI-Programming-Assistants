#include <vector>

using namespace std;

class Solution {
public:
    vector<int> countPoints(vector<vector<int>>& points, vector<vector<int>>& queries) {
        vector<int> result;
        for (auto& query : queries) {
            int count = 0;
            int x = query[0], y = query[1], r = query[2];
            for (auto& point : points) {
                int px = point[0], py = point[1];
                if ((px - x) * (px - x) + (py - y) * (py - y) <= r * r) {
                    count++;
                }
            }
            result.push_back(count);
        }
        return result;
    }
};