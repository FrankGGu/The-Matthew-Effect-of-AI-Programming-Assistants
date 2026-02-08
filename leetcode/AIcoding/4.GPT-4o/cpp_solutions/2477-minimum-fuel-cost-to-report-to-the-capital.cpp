class Solution {
public:
    long long minimumFuelCost(vector<vector<int>>& roads, int seats) {
        vector<vector<int>> graph(roads.size() + 1);
        for (const auto& road : roads) {
            graph[road[0]].push_back(road[1]);
            graph[road[1]].push_back(road[0]);
        }

        long long totalFuel = 0;
        vector<bool> visited(graph.size(), false);

        function<int(int)> dfs = [&](int node) {
            visited[node] = true;
            int passengers = 1;
            for (int neighbor : graph[node]) {
                if (!visited[neighbor]) {
                    passengers += dfs(neighbor);
                }
            }
            if (node != 0) {
                totalFuel += (passengers + seats - 1) / seats;
            }
            return passengers;
        };

        dfs(0);
        return totalFuel;
    }
};