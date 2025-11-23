class Solution {
public:
    int largestPathValue(string colors, vector<vector<int>>& edges) {
        int n = colors.size();
        vector<vector<int>> adj(n);
        vector<int> inDegree(n, 0);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            inDegree[edge[1]]++;
        }

        queue<int> q;
        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) {
                q.push(i);
            }
        }

        vector<vector<int>> count(n, vector<int>(26, 0));
        for (int i = 0; i < n; ++i) {
            count[i][colors[i] - 'a']++;
        }

        int res = 0;
        int visited = 0;
        while (!q.empty()) {
            int u = q.front();
            q.pop();
            visited++;

            for (int v : adj[u]) {
                for (int c = 0; c < 26; ++c) {
                    count[v][c] = max(count[v][c], count[u][c] + (colors[v] - 'a' == c ? 1 : 0));
                }
                if (--inDegree[v] == 0) {
                    q.push(v);
                }
            }

            res = max(res, *max_element(count[u].begin(), count[u].end()));
        }

        return visited == n ? res : -1;
    }
};