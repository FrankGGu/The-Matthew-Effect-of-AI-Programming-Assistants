class Solution {
public:
    vector<int> loudAndRich(vector<vector<int>>& richer, vector<int>& quiet) {
        int n = quiet.size();
        vector<vector<int>> graph(n);
        vector<int> inDegree(n, 0);
        for (const auto& r : richer) {
            graph[r[1]].push_back(r[0]);
            inDegree[r[0]]++;
        }

        vector<int> result(n);
        iota(result.begin(), result.end(), 0);
        queue<int> q;

        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) q.push(i);
        }

        while (!q.empty()) {
            int u = q.front();
            q.pop();
            for (int v : graph[u]) {
                if (quiet[result[u]] < quiet[result[v]]) {
                    result[v] = result[u];
                }
                if (--inDegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        return result;
    }
};