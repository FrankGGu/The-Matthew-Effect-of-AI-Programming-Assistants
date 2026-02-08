class Solution {
public:
    vector<int> findEdges(int n, vector<vector<int>>& edges) {
        vector<int> result(edges.size(), 0);
        vector<vector<int>> graph(n + 1);
        vector<int> dist(n + 1, INT_MAX);

        for (auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        dist[1] = 0;
        queue<int> q;
        q.push(1);

        while (!q.empty()) {
            int node = q.front();
            q.pop();
            for (int neighbor : graph[node]) {
                if (dist[neighbor] > dist[node] + 1) {
                    dist[neighbor] = dist[node] + 1;
                    q.push(neighbor);
                }
            }
        }

        for (int i = 0; i < edges.size(); ++i) {
            if (dist[edges[i][0]] + 1 == dist[edges[i][1]] || dist[edges[i][1]] + 1 == dist[edges[i][0]]) {
                result[i] = 1;
            }
        }

        return result;
    }
};