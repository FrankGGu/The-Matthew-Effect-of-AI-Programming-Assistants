class Solution {
public:
    double maxProbability(int n, vector<vector<int>>& edges, vector<double>& succProb, int start, int end) {
        vector<vector<pair<int, double>>> adj(n);
        for (int i = 0; i < edges.size(); ++i) {
            int u = edges[i][0];
            int v = edges[i][1];
            double prob = succProb[i];
            adj[u].emplace_back(v, prob);
            adj[v].emplace_back(u, prob);
        }

        vector<double> prob(n, 0.0);
        prob[start] = 1.0;

        priority_queue<pair<double, int>> pq;
        pq.push({1.0, start});

        while (!pq.empty()) {
            auto [currentProb, u] = pq.top();
            pq.pop();

            if (u == end) {
                return currentProb;
            }

            if (currentProb < prob[u]) {
                continue;
            }

            for (auto [v, edgeProb] : adj[u]) {
                double nextProb = currentProb * edgeProb;
                if (nextProb > prob[v]) {
                    prob[v] = nextProb;
                    pq.push({nextProb, v});
                }
            }
        }

        return 0.0;
    }
};