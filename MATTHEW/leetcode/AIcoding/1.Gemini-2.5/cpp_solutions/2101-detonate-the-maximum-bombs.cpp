#include <vector>
#include <algorithm>

class Solution {
public:
    void dfs(int u, const std::vector<std::vector<int>>& adj, std::vector<bool>& visited, int& count) {
        visited[u] = true;
        count++;
        for (int v : adj[u]) {
            if (!visited[v]) {
                dfs(v, adj, visited, count);
            }
        }
    }

    int maximumDetonations(std::vector<std::vector<int>>& bombs) {
        int n = bombs.size();
        if (n == 0) return 0;

        std::vector<std::vector<int>> adj(n);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i == j) continue;

                long long x1 = bombs[i][0];
                long long y1 = bombs[i][1];
                long long r1 = bombs[i][2];

                long long x2 = bombs[j][0];
                long long y2 = bombs[j][1];

                long long dx = x1 - x2;
                long long dy = y1 - y2;

                if (dx * dx + dy * dy <= r1 * r1) {
                    adj[i].push_back(j);
                }
            }
        }

        int max_detonated = 0;

        for (int i = 0; i < n; ++i) {
            std::vector<bool> visited(n, false);
            int current_detonated_count = 0;
            dfs(i, adj, visited, current_detonated_count);
            max_detonated = std::max(max_detonated, current_detonated_count);
        }

        return max_detonated;
    }
};