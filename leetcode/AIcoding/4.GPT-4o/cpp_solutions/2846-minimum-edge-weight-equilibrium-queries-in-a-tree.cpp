class Solution {
public:
    vector<int> minEdgeWeightEquilibrium(int n, vector<vector<int>>& edges, vector<vector<int>>& queries) {
        vector<vector<pair<int, int>>> graph(n);
        for (auto& edge : edges) {
            graph[edge[0]].emplace_back(edge[1], edge[2]);
            graph[edge[1]].emplace_back(edge[0], edge[2]);
        }

        vector<int> result;
        for (auto& query : queries) {
            int u = query[0], v = query[1], weight = query[2];
            result.push_back(dfs(u, v, weight, graph));
        }

        return result;
    }

private:
    int dfs(int u, int v, int weight, vector<vector<pair<int, int>>>& graph, int parent = -1) {
        if (u == v) return 0;
        int minWeight = INT_MAX;
        for (auto& [neighbor, edgeWeight] : graph[u]) {
            if (neighbor != parent) {
                int edgeMin = dfs(neighbor, v, weight, graph, u);
                if (edgeMin != -1) {
                    minWeight = min(minWeight, max(edgeWeight, edgeMin));
                }
            }
        }
        return minWeight == INT_MAX ? -1 : minWeight;
    }
};