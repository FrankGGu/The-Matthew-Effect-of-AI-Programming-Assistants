#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> countSubtrees(int n, vector<vector<int>>& edges) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0] - 1].push_back(edge[1] - 1);
            adj[edge[1] - 1].push_back(edge[0] - 1);
        }

        vector<int> ans(n - 1, 0);
        for (int i = 1; i < (1 << n); ++i) {
            vector<int> nodes;
            for (int j = 0; j < n; ++j) {
                if ((i >> j) & 1) {
                    nodes.push_back(j);
                }
            }

            int m = nodes.size();
            vector<vector<int>> sub_adj(m, vector<int>(m, 0));
            int edge_count = 0;
            for (int u : nodes) {
                for (int v : nodes) {
                    if (u == v) continue;
                    bool found = false;
                    for (auto& edge : edges) {
                        int a = edge[0] - 1;
                        int b = edge[1] - 1;
                        if ((a == u && b == v) || (a == v && b == u)) {
                            found = true;
                            break;
                        }
                    }
                    if (found) {
                        int u_idx = find(nodes.begin(), nodes.end(), u) - nodes.begin();
                        int v_idx = find(nodes.begin(), nodes.end(), v) - nodes.begin();
                        sub_adj[u_idx][v_idx] = 1;
                        sub_adj[v_idx][u_idx] = 1;
                        edge_count++;
                    }
                }
            }
            edge_count /= 2;

            if (edge_count != m - 1) continue;

            vector<bool> visited(m, false);
            vector<int> q;
            q.push_back(0);
            visited[0] = true;
            int head = 0;
            int count = 0;

            while (head < q.size()) {
                int u_idx = q[head++];
                count++;
                for (int v_idx = 0; v_idx < m; ++v_idx) {
                    if (sub_adj[u_idx][v_idx] == 1 && !visited[v_idx]) {
                        visited[v_idx] = true;
                        q.push_back(v_idx);
                    }
                }
            }
            if (count != m) continue;

            int max_dist = 0;
            for (int start_node : nodes) {
                vector<int> dist(n, -1);
                vector<int> queue;
                dist[start_node] = 0;
                queue.push_back(start_node);
                int head_index = 0;

                while (head_index < queue.size()) {
                    int u = queue[head_index++];
                    for (int v : adj[u]) {
                        bool in_nodes = false;
                        for(int node : nodes){
                            if(node == v) {
                                in_nodes = true;
                                break;
                            }
                        }
                        if(in_nodes && dist[v] == -1) {
                            dist[v] = dist[u] + 1;
                            queue.push_back(v);
                        }
                    }
                }

                for (int end_node : nodes) {
                    max_dist = max(max_dist, dist[end_node]);
                }
            }

            if (max_dist > 0) {
                ans[max_dist - 1]++;
            }
        }

        return ans;
    }
};