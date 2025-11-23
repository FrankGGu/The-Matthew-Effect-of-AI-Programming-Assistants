class Solution {
public:
    int magnificentSets(int n, vector<vector<int>>& edges) {
        vector<vector<int>> adj(n + 1);
        for (auto& e : edges) {
            adj[e[0]].push_back(e[1]);
            adj[e[1]].push_back(e[0]);
        }

        vector<int> color(n + 1, -1);
        vector<vector<int>> components;

        for (int i = 1; i <= n; ++i) {
            if (color[i] == -1) {
                queue<int> q;
                q.push(i);
                color[i] = 0;
                vector<int> component;
                component.push_back(i);

                bool isBipartite = true;

                while (!q.empty()) {
                    int u = q.front();
                    q.pop();
                    for (int v : adj[u]) {
                        if (color[v] == -1) {
                            color[v] = color[u] ^ 1;
                            q.push(v);
                            component.push_back(v);
                        } else if (color[v] == color[u]) {
                            isBipartite = false;
                        }
                    }
                }

                if (!isBipartite) {
                    return -1;
                }
                components.push_back(component);
            }
        }

        int res = 0;

        for (auto& component : components) {
            int maxDepth = 0;
            for (int start : component) {
                vector<int> depth(n + 1, -1);
                queue<int> q;
                q.push(start);
                depth[start] = 1;
                int currentMax = 1;

                while (!q.empty()) {
                    int u = q.front();
                    q.pop();
                    for (int v : adj[u]) {
                        if (depth[v] == -1) {
                            depth[v] = depth[u] + 1;
                            currentMax = max(currentMax, depth[v]);
                            q.push(v);
                        }
                    }
                }
                maxDepth = max(maxDepth, currentMax);
            }
            res += maxDepth;
        }

        return res;
    }
};