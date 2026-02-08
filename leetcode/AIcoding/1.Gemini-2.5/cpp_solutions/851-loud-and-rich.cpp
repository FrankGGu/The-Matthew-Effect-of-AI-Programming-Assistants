#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    std::vector<int> adj_rev[10005];
    std::vector<int> quiet_val;
    std::vector<int> ans;

    int dfs(int u) {
        if (ans[u] != -1) {
            return ans[u];
        }

        int current_quietest_person_idx = u;

        for (int v : adj_rev[u]) {
            int quietest_person_for_v = dfs(v);
            if (quiet_val[quietest_person_for_v] < quiet_val[current_quietest_person_idx]) {
                current_quietest_person_idx = quietest_person_for_v;
            }
        }

        ans[u] = current_quietest_person_idx;
        return ans[u];
    }

    std::vector<int> loudAndRich(std::vector<std::vector<int>>& richer, std::vector<int>& quiet) {
        int n = quiet.size();

        quiet_val = quiet;
        ans.assign(n, -1);

        for (int i = 0; i < n; ++i) {
            adj_rev[i].clear();
        }

        for (const auto& edge : richer) {
            int u = edge[0];
            int v = edge[1];
            adj_rev[v].push_back(u);
        }

        for (int i = 0; i < n; ++i) {
            dfs(i);
        }

        return ans;
    }
};