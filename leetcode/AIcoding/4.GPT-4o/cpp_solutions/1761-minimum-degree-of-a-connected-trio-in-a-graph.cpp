class Solution {
public:
    int minTrioDegree(int n, vector<vector<int>>& edges) {
        vector<vector<int>> graph(n + 1);
        vector<int> degree(n + 1, 0);

        for (auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
            degree[edge[0]]++;
            degree[edge[1]]++;
        }

        int minDegree = INT_MAX;

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j < graph[i].size(); j++) {
                for (int k = j + 1; k < graph[i].size(); k++) {
                    int u = graph[i][j], v = graph[i][k];
                    if (find(graph[u].begin(), graph[u].end(), v) != graph[u].end()) {
                        int trioDegree = degree[i] + degree[u] + degree[v] - 6;
                        minDegree = min(minDegree, trioDegree);
                    }
                }
            }
        }

        return minDegree == INT_MAX ? -1 : minDegree;
    }
};