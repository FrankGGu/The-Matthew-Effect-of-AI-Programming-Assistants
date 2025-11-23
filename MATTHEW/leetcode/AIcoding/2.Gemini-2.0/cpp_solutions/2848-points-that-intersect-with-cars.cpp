#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numberOfPoints(vector<vector<int>>& nums) {
        vector<int> points;
        for (auto& car : nums) {
            for (int i = car[0]; i <= car[1]; ++i) {
                points.push_back(i);
            }
        }

        sort(points.begin(), points.end());
        points.erase(unique(points.begin(), points.end()), points.end());

        return points.size();
    }
};