#include <vector>
#include <utility> // For std::pair

class Solution {
public:
    long long ans = 0;
    std::vector<std::vector<std::pair<int, int>>> adj;
    int K;

    std::vector<int> dfs(int u, int p) {
        std::vector<int> counts(K, 0);
        counts[0] = 1;

        for (auto& edge : adj[u]) {
            int v = edge.first;
            int w = edge.second;
            if (v == p) continue;

            std::vector<int> child_counts = dfs(v, u);

            int target_rem_sum = (K - (w % K)) % K;

            for (int r1 = 0; r1 < K; ++r1) {
                if (counts[r1] == 0) continue;
                int r2_needed = (target_rem_sum - r1 + K) % K;
                if (child_counts[r2_needed] > 0) {
                    ans += (long long)counts[r1] * child_counts[r2_needed];
                }
            }

            for (int r2 = 0; r2 < K; ++r2) {
                if (child_counts[r2] == 0) continue;
                counts[(w + r2) % K] += child_counts[r2];
            }
        }
        return counts;
    }

    long long countPairsOfConnectableCities(int n, std::vector<std::vector<int>>& edges, int k) {
        adj.resize(n);
        K = k;
        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            adj[u].push_back({v, w});
            adj[v].push_back({u, w});
        }

        dfs(0, -1);

        return ans;
    }
};