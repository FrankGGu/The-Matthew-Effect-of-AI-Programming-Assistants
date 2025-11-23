#include <vector>
#include <queue>
#include <utility>

using namespace std;

class Solution {
public:
    vector<vector<int>> kClosest(vector<vector<int>>& points, int k) {
        auto cmp = [](const pair<int, int>& a, const pair<int, int>& b) {
            return a.first > b.first;
        };
        priority_queue<pair<int, int>, vector<pair<int, int>>, decltype(cmp)> pq(cmp);

        for (const auto& point : points) {
            int dist = point[0] * point[0] + point[1] * point[1];
            pq.push({dist, point[0]});
            if (pq.size() > k) {
                pq.pop();
            }
        }

        vector<vector<int>> result;
        while (!pq.empty()) {
            auto p = pq.top();
            pq.pop();
            result.push_back({p.second, p.first});
        }

        return result;
    }
};