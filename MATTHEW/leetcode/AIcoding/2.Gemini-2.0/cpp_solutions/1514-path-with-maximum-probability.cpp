#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    double maxProbability(int n, vector<vector<int>>& edges, vector<double>& succProb, int start_node, int end_node) {
        vector<vector<pair<int, double>>> adj(n);
        for (int i = 0; i < edges.size(); ++i) {
            adj[edges[i][0]].push_back({edges[i][1], succProb[i]});
            adj[edges[i][1]].push_back({edges[i][0], succProb[i]});
        }

        vector<double> prob(n, 0.0);
        prob[start_node] = 1.0;

        priority_queue<pair<double, int>> pq;
        pq.push({1.0, start_node});

        while (!pq.empty()) {
            double current_prob = pq.top().first;
            int current_node = pq.top().second;
            pq.pop();

            if (current_prob < prob[current_node]) continue;

            for (auto& edge : adj[current_node]) {
                int neighbor = edge.first;
                double edge_prob = edge.second;

                if (prob[current_node] * edge_prob > prob[neighbor]) {
                    prob[neighbor] = prob[current_node] * edge_prob;
                    pq.push({prob[neighbor], neighbor});
                }
            }
        }

        return prob[end_node];
    }
};