class Solution {
public:
    int maximumInvitations(vector<int>& favorite) {
        int n = favorite.size();
        vector<int> in_degree(n, 0);
        for (int i = 0; i < n; ++i) {
            in_degree[favorite[i]]++;
        }

        queue<int> q;
        vector<int> depth(n, 1);
        for (int i = 0; i < n; ++i) {
            if (in_degree[i] == 0) {
                q.push(i);
            }
        }

        while (!q.empty()) {
            int u = q.front();
            q.pop();
            int v = favorite[u];
            depth[v] = max(depth[v], depth[u] + 1);
            if (--in_degree[v] == 0) {
                q.push(v);
            }
        }

        int max_cycle = 0;
        int sum_2cycles = 0;
        for (int i = 0; i < n; ++i) {
            if (in_degree[i] == 0) continue;
            int cycle_len = 0;
            int j = i;
            while (in_degree[j] != 0) {
                in_degree[j] = 0;
                j = favorite[j];
                cycle_len++;
            }
            if (cycle_len == 2) {
                sum_2cycles += depth[i] + depth[favorite[i]];
            } else {
                max_cycle = max(max_cycle, cycle_len);
            }
        }

        return max(max_cycle, sum_2cycles);
    }
};