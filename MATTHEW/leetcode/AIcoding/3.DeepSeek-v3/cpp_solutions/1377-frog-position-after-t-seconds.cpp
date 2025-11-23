class Solution {
public:
    double frogPosition(int n, vector<vector<int>>& edges, int t, int target) {
        vector<vector<int>> graph(n + 1);
        for (auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }
        queue<pair<int, double>> q;
        q.push({1, 1.0});
        vector<bool> visited(n + 1, false);
        visited[1] = true;
        double res = 0.0;
        while (!q.empty() && t >= 0) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                auto node = q.front();
                q.pop();
                int u = node.first;
                double prob = node.second;
                int count = 0;
                for (int v : graph[u]) {
                    if (!visited[v]) {
                        count++;
                    }
                }
                if (u == target) {
                    if (t == 0 || count == 0) {
                        res = prob;
                    } else {
                        res = 0.0;
                    }
                    return res;
                }
                for (int v : graph[u]) {
                    if (!visited[v]) {
                        visited[v] = true;
                        q.push({v, prob / count});
                    }
                }
            }
            t--;
        }
        return res;
    }
};