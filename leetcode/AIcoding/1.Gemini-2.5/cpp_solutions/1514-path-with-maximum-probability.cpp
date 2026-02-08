#include <vector>
#include <queue>
#include <utility>

class Solution {
public:
    double maxProbability(int n, std::vector<std::vector<int>>& edges, std::vector<double>& succProb, int start, int end) {
        std::vector<std::vector<std::pair<int, double>>> adj(n);
        for (int i = 0; i < edges.size(); ++i) {
            int u = edges[i][0];
            int v = edges[i][1];
            double p = succProb[i];
            adj[u].push_back({v, p});
            adj[v].push_back({u, p});
        }

        std::vector<double> maxProb(n, 0.0);
        maxProb[start] = 1.0;

        std::priority_queue<std::pair<double, int>> pq;
        pq.push({1.0, start});

        while (!pq.empty()) {
            auto [currentProb, u] = pq.top();
            pq.pop();

            if (currentProb < maxProb[u]) {
                continue;
            }

            if (u == end) {
                return currentProb;
            }

            for (auto& edge : adj[u]) {
                int v = edge.first;
                double edgeProb = edge.second;
                double newProb = currentProb * edgeProb;

                if (newProb > maxProb[v]) {
                    maxProb[v] = newProb;
                    pq.push({newProb, v});
                }
            }
        }

        return 0.0;
    }
};