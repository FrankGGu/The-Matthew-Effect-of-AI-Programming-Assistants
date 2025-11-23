#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<int> kthNearestObstacle(vector<int>& obstacles, vector<vector<int>>& queries) {
        vector<int> res;
        for (auto& q : queries) {
            int x = q[0], k = q[1];
            vector<int> distances;
            for (int o : obstacles) {
                distances.push_back(abs(o - x));
            }
            sort(distances.begin(), distances.end());
            res.push_back(distances[k - 1]);
        }
        return res;
    }
};