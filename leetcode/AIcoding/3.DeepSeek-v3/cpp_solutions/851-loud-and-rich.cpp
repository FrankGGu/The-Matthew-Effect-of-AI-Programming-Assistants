class Solution {
public:
    vector<int> loudAndRich(vector<vector<int>>& richer, vector<int>& quiet) {
        int n = quiet.size();
        vector<vector<int>> graph(n);
        vector<int> inDegree(n, 0);
        for (auto& edge : richer) {
            int u = edge[0], v = edge[1];
            graph[u].push_back(v);
            inDegree[v]++;
        }

        queue<int> q;
        vector<int> answer(n);
        for (int i = 0; i < n; ++i) {
            answer[i] = i;
            if (inDegree[i] == 0) {
                q.push(i);
            }
        }

        while (!q.empty()) {
            int u = q.front();
            q.pop();
            for (int v : graph[u]) {
                if (quiet[answer[u]] < quiet[answer[v]]) {
                    answer[v] = answer[u];
                }
                if (--inDegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        return answer;
    }
};