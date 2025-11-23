#include <vector>
#include <queue>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<vector<int>> kClosest(vector<vector<int>>& points, int k) {
        priority_queue<pair<double, vector<int>>> pq;
        for (auto& point : points) {
            double dist = sqrt(pow(point[0], 2) + pow(point[1], 2));
            pq.push({dist, point});
            if (pq.size() > k) {
                pq.pop();
            }
        }
        vector<vector<int>> result;
        while (!pq.empty()) {
            result.push_back(pq.top().second);
            pq.pop();
        }
        return result;
    }
};