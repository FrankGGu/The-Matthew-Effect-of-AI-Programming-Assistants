#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findMinHeightTrees(int n, vector<vector<int>>& edges) {
        if (n == 1) return 0;
        vector<vector<int>> adj(n);
        vector<int> degree(n, 0);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
            degree[edge[0]]++;
            degree[edge[1]]++;
        }

        vector<int> leaves;
        for (int i = 0; i < n; i++) {
            if (degree[i] == 1) {
                leaves.push_back(i);
            }
        }

        int count = n;
        while (count > 2) {
            int size = leaves.size();
            count -= size;
            vector<int> newLeaves;
            for (int leaf : leaves) {
                for (int neighbor : adj[leaf]) {
                    degree[neighbor]--;
                    if (degree[neighbor] == 1) {
                        newLeaves.push_back(neighbor);
                    }
                }
            }
            leaves = newLeaves;
        }

        int u = leaves[0];
        int v = leaves[1];
        vector<int> dist(n, -1);
        vector<int> q;
        q.push_back(u);
        dist[u] = 0;
        int head = 0;
        while (head < q.size()) {
            int node = q[head++];
            for (int neighbor : adj[node]) {
                if (dist[neighbor] == -1) {
                    dist[neighbor] = dist[node] + 1;
                    q.push_back(neighbor);
                }
            }
        }
        return dist[v];
    }

    int findMinDiameter(int n1, int n2, vector<vector<int>>& edges, vector<vector<int>>& newEdges) {
        vector<vector<int>> adj1(n1);
        for (auto& edge : edges) {
            adj1[edge[0]].push_back(edge[1]);
            adj1[edge[1]].push_back(edge[0]);
        }

        function<pair<int, int>(int, vector<vector<int>>&)> bfs = [&](int start, vector<vector<int>>& adj) {
            int n = adj.size();
            vector<int> dist(n, -1);
            vector<int> q;
            q.push_back(start);
            dist[start] = 0;
            int head = 0;
            int farNode = start;
            while (head < q.size()) {
                int node = q[head++];
                if (dist[node] > dist[farNode]) {
                    farNode = node;
                }
                for (int neighbor : adj[node]) {
                    if (dist[neighbor] == -1) {
                        dist[neighbor] = dist[node] + 1;
                        q.push_back(neighbor);
                    }
                }
            }
            return {farNode, dist[farNode]};
        };

        auto getDiameter = [&](vector<vector<int>>& adj) {
            int n = adj.size();
            auto [u, _] = bfs(0, adj);
            auto [v, diameter] = bfs(u, adj);
            return diameter;
        };

        int diameter1 = getDiameter(adj1);

        vector<vector<int>> adj2(n2);
        for (auto& edge : newEdges) {
            adj2[edge[0]].push_back(edge[1]);
            adj2[edge[1]].push_back(edge[0]);
        }

        int diameter2 = getDiameter(adj2);

        auto [u1, _] = bfs(0, adj1);
        auto [v1, _] = bfs(u1, adj1);
        auto [u2, _] = bfs(0, adj2);
        auto [v2, _] = bfs(u2, adj2);

        auto distBetween = [&](int start, int end, vector<vector<int>>& adj, int n) {
            vector<int> dist(n, -1);
            vector<int> q;
            q.push_back(start);
            dist[start] = 0;
            int head = 0;
            while (head < q.size()) {
                int node = q[head++];
                if (node == end) return dist[end];
                for (int neighbor : adj[node]) {
                    if (dist[neighbor] == -1) {
                        dist[neighbor] = dist[node] + 1;
                        q.push_back(neighbor);
                    }
                }
            }
            return -1;
        };

        int dist_u1_u2 = distBetween(u1, u2 + n1, edges, n1);
        if (dist_u1_u2 == -1) {
            edges.push_back({u1, u2 + n1});
            edges.push_back({u2 + n1, u1});
            dist_u1_u2 = distBetween(u1, u2 + n1, edges, n1 + n2);
        }

        int dist_u1_v2 = distBetween(u1, v2 + n1, edges, n1);
        if (dist_u1_v2 == -1) {
            edges.push_back({u1, v2 + n1});
            edges.push_back({v2 + n1, u1});
            dist_u1_v2 = distBetween(u1, v2 + n1, edges, n1 + n2);
        }

        int dist_v1_u2 = distBetween(v1, u2 + n1, edges, n1);
        if (dist_v1_u2 == -1) {
            edges.push_back({v1, u2 + n1});
            edges.push_back({u2 + n1, v1});
            dist_v1_u2 = distBetween(v1, u2 + n1, edges, n1 + n2);
        }

        int dist_v1_v2 = distBetween(v1, v2 + n1, edges, n1);
        if (dist_v1_v2 == -1) {
            edges.push_back({v1, v2 + n1});
            edges.push_back({v2 + n1, v1});
            dist_v1_v2 = distBetween(v1, v2 + n1, edges, n1 + n2);
        }

        int maxDiameter = max({diameter1, diameter2, dist_u1_u2 + 1, dist_u1_v2 + 1, dist_v1_u2 + 1, dist_v1_v2 + 1});

        vector<vector<int>> mergedAdj(n1 + n2);
        for (auto& edge : edges) {
            mergedAdj[edge[0]].push_back(edge[1]);
            mergedAdj[edge[1]].push_back(edge[0]);
        }

        int mergedDiameter = getDiameter(mergedAdj);

        int minDiameter = min(mergedDiameter, maxDiameter);

        return minDiameter;
    }
};