class Solution {
public:
    int minimumTime(int n, vector<vector<int>>& relations, vector<int>& time) {
        vector<vector<int>> graph(n + 1);
        vector<int> inDegree(n + 1, 0);
        vector<int> maxTime(n + 1, 0);

        for (const auto& rel : relations) {
            graph[rel[0]].push_back(rel[1]);
            inDegree[rel[1]]++;
        }

        queue<int> q;
        for (int i = 1; i <= n; ++i) {
            if (inDegree[i] == 0) {
                q.push(i);
                maxTime[i] = time[i - 1];
            }
        }

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            for (int v : graph[u]) {
                maxTime[v] = max(maxTime[v], maxTime[u] + time[v - 1]);
                if (--inDegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        return *max_element(maxTime.begin(), maxTime.end());
    }
};