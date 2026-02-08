class Solution {
public:
    vector<int> countSubtrees(int n, string labels, vector<vector<int>>& edges) {
        vector<vector<int>> graph(n);
        for (auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<int> result(n, 0);
        vector<int> count(26, 0);
        vector<bool> visited(n, false);

        function<void(int)> dfs = [&](int node) {
            visited[node] = true;
            count[labels[node] - 'a']++;
            for (int neighbor : graph[node]) {
                if (!visited[neighbor]) {
                    dfs(neighbor);
                    for (int i = 0; i < 26; i++) {
                        count[i] += count[i];
                    }
                }
            }
            result[node] = count[labels[node] - 'a'];
            count[labels[node] - 'a']--;
        };

        dfs(0);
        return result;
    }
};