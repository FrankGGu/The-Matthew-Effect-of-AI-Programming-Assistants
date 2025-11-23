#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    long long minimumFuelCost(vector<vector<int>>& roads, int seats) {
        int n = roads.size() + 1;
        vector<vector<int>> adj(n);
        for (auto& road : roads) {
            adj[road[0]].push_back(road[1]);
            adj[road[1]].push_back(road[0]);
        }

        vector<int> people(n, 1);
        vector<bool> visited(n, false);
        long long fuel = 0;

        function<void(int)> dfs = [&](int u) {
            visited[u] = true;
            for (int v : adj[u]) {
                if (!visited[v]) {
                    dfs(v);
                    people[u] += people[v];
                    fuel += (people[v] + seats - 1) / seats;
                }
            }
        };

        dfs(0);

        return fuel;
    }
};