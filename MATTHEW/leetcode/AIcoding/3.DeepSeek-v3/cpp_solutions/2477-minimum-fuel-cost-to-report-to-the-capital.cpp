class Solution {
public:
    long long minimumFuelCost(vector<vector<int>>& roads, int seats) {
        int n = roads.size() + 1;
        vector<vector<int>> adj(n);
        for (auto& road : roads) {
            adj[road[0]].push_back(road[1]);
            adj[road[1]].push_back(road[0]);
        }
        long long fuel = 0;
        function<int(int, int)> dfs = [&](int node, int parent) {
            int people = 1;
            for (int neighbor : adj[node]) {
                if (neighbor != parent) {
                    people += dfs(neighbor, node);
                }
            }
            if (node != 0) {
                fuel += (people + seats - 1) / seats;
            }
            return people;
        };
        dfs(0, -1);
        return fuel;
    }
};