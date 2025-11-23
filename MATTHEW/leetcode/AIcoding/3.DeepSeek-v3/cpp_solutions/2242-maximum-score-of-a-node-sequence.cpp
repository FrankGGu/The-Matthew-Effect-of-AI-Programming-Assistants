class Solution {
public:
    int maximumScore(vector<int>& scores, vector<vector<int>>& edges) {
        int n = scores.size();
        vector<vector<pair<int, int>>> adj(n);
        for (auto& e : edges) {
            int u = e[0], v = e[1];
            adj[u].emplace_back(scores[v], v);
            adj[v].emplace_back(scores[u], u);
        }

        for (auto& neighbors : adj) {
            if (neighbors.size() > 3) {
                partial_sort(neighbors.begin(), neighbors.begin() + 3, neighbors.end(), greater<pair<int, int>>());
                neighbors.resize(3);
            } else {
                sort(neighbors.begin(), neighbors.end(), greater<pair<int, int>>());
            }
        }

        int max_score = -1;
        for (auto& e : edges) {
            int u = e[0], v = e[1];
            int current = scores[u] + scores[v];
            for (auto& [score_a, a] : adj[u]) {
                if (a == v) continue;
                for (auto& [score_b, b] : adj[v]) {
                    if (b == u || b == a) continue;
                    max_score = max(max_score, current + score_a + score_b);
                }
            }
        }
        return max_score;
    }
};