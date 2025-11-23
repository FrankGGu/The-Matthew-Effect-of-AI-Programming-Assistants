#include <vector>
#include <numeric>

class Solution {
public:
    long long minimumFuelCost(std::vector<std::vector<int>>& roads, int seats) {
        int n = roads.size() + 1;
        std::vector<std::vector<int>> adj(n);
        for (const auto& road : roads) {
            adj[road[0]].push_back(road[1]);
            adj[road[1]].push_back(road[0]);
        }

        long long totalFuel = 0;
        dfs(0, -1, adj, seats, totalFuel);
        return totalFuel;
    }

private:
    long long dfs(int u, int parent, const std::vector<std::vector<int>>& adj, int seats, long long& totalFuel) {
        long long peopleInSubtree = 1;

        for (int v : adj[u]) {
            if (v == parent) {
                continue;
            }
            peopleInSubtree += dfs(v, u, adj, seats, totalFuel);
        }

        if (u != 0) {
            long long carsNeeded = (peopleInSubtree + seats - 1) / seats;
            totalFuel += carsNeeded;
        }

        return peopleInSubtree;
    }
};