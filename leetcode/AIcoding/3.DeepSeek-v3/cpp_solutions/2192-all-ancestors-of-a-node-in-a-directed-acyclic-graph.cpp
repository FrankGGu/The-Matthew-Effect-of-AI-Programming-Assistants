class Solution {
public:
    vector<vector<int>> getAncestors(int n, vector<vector<int>>& edges) {
        vector<vector<int>> adj(n);
        vector<set<int>> ancestors(n);
        vector<int> inDegree(n, 0);

        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            inDegree[edge[1]]++;
        }

        queue<int> q;
        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) {
                q.push(i);
            }
        }

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            for (int v : adj[u]) {
                ancestors[v].insert(u);
                for (int ancestor : ancestors[u]) {
                    ancestors[v].insert(ancestor);
                }
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        vector<vector<int>> result(n);
        for (int i = 0; i < n; ++i) {
            result[i] = vector<int>(ancestors[i].begin(), ancestors[i].end());
        }

        return result;
    }
};