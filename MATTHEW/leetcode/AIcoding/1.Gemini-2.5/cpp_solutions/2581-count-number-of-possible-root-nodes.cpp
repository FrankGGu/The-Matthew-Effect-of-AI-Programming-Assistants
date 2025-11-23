#include <vector>
#include <set>
#include <utility>
#include <functional>

class Solution {
public:
    int rootCount(std::vector<std::vector<int>>& edges, std::vector<std::vector<int>>& guesses, int k) {
        int n = edges.size() + 1;
        std::vector<std::vector<int>> adj(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        std::set<std::pair<int, int>> guess_set;
        for (const auto& guess : guesses) {
            guess_set.insert({guess[0], guess[1]});
        }

        int count0 = 0;

        std::function<void(int, int)> dfs1 = 
            [&](int u, int p) {
            for (int v : adj[u]) {
                if (v == p) continue;
                if (guess_set.count({u, v})) {
                    count0++;
                }
                dfs1(v, u);
            }
        };

        dfs1(0, -1);

        std::vector<int> dp(n);
        dp[0] = count0;

        std::function<void(int, int)> reroot_dfs = 
            [&](int u, int p) {
            for (int v : adj[u]) {
                if (v == p) continue;
                int score_v = dp[u];
                if (guess_set.count({u, v})) {
                    score_v--;
                }
                if (guess_set.count({v, u})) {
                    score_v++;
                }
                dp[v] = score_v;
                reroot_dfs(v, u);
            }
        };

        reroot_dfs(0, -1);

        int result = 0;
        for (int score : dp) {
            if (score >= k) {
                result++;
            }
        }

        return result;
    }
};