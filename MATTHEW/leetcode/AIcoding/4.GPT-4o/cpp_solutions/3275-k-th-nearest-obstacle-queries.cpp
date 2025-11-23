class Solution {
public:
    vector<int> kNearestObstacles(int rows, int cols, vector<vector<int>>& obstacles, vector<vector<int>>& queries) {
        vector<int> result;
        set<pair<int, int>> obsSet;
        for (const auto& obs : obstacles) {
            obsSet.insert({obs[0], obs[1]});
        }

        for (const auto& query : queries) {
            int k = query[2];
            priority_queue<pair<int, pair<int, int>>> pq;
            for (const auto& obs : obstacles) {
                int dist = abs(obs[0] - query[0]) + abs(obs[1] - query[1]);
                if (dist <= k) {
                    pq.push({dist, {obs[0], obs[1]}});
                }
            }

            vector<pair<int, int>> nearest;
            while (!pq.empty() && nearest.size() < k) {
                nearest.push_back(pq.top().second);
                pq.pop();
            }

            result.push_back(nearest.size());
        }

        return result;
    }
};