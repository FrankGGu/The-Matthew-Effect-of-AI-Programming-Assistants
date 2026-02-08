class Solution {
public:
    int minScore(int n, vector<vector<int>>& roads) {
        vector<vector<pair<int, int>>> graph(n + 1);
        for (const auto& road : roads) {
            graph[road[0]].emplace_back(road[1], road[2]);
            graph[road[1]].emplace_back(road[0], road[2]);
        }

        vector<bool> visited(n + 1, false);
        int minScorePath = INT_MAX;
        queue<int> q;
        q.push(1);
        visited[1] = true;

        while (!q.empty()) {
            int city = q.front();
            q.pop();
            for (const auto& [nextCity, score] : graph[city]) {
                minScorePath = min(minScorePath, score);
                if (!visited[nextCity]) {
                    visited[nextCity] = true;
                    q.push(nextCity);
                }
            }
        }

        return minScorePath;
    }
};