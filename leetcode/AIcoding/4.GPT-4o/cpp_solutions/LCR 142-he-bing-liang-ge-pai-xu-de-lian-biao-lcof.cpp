class Solution {
public:
    bool canComplete(int n, vector<vector<int>>& dependencies, vector<int>& work) {
        vector<int> indegree(n, 0);
        vector<vector<int>> graph(n);

        for (const auto& dep : dependencies) {
            graph[dep[0]].push_back(dep[1]);
            indegree[dep[1]]++;
        }

        queue<int> q;
        for (int i = 0; i < n; ++i) {
            if (indegree[i] == 0) {
                q.push(i);
            }
        }

        vector<int> dp(n, 0);
        while (!q.empty()) {
            int node = q.front();
            q.pop();
            dp[node] += work[node];

            for (int neighbor : graph[node]) {
                indegree[neighbor]--;
                dp[neighbor] = max(dp[neighbor], dp[node]);
                if (indegree[neighbor] == 0) {
                    q.push(neighbor);
                }
            }
        }

        for (int i = 0; i < n; ++i) {
            if (indegree[i] > 0) {
                return false;
            }
        }

        return true;
    }
};