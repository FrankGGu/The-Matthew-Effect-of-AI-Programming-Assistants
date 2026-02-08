class Solution {
public:
    int traffic(int n, vector<vector<int>>& roads) {
        vector<vector<int>> graph(n + 1);
        for (const auto& road : roads) {
            graph[road[0]].push_back(road[1]);
            graph[road[1]].push_back(road[0]);
        }

        vector<int> visited(n + 1, 0);
        queue<int> q;
        q.push(1);
        visited[1] = 1;
        int trafficCount = 0;

        while (!q.empty()) {
            int size = q.size();
            trafficCount++;
            for (int i = 0; i < size; i++) {
                int node = q.front();
                q.pop();
                for (int neighbor : graph[node]) {
                    if (!visited[neighbor]) {
                        visited[neighbor] = 1;
                        q.push(neighbor);
                    }
                }
            }
        }
        return trafficCount;
    }
};