class Solution {
public:
    int minEdgeReversals(int n, vector<vector<int>>& edges) {
        vector<vector<int>> graph(n);
        for (auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(-edge[0]);
        }

        vector<int> dist(n, INT_MAX);
        dist[0] = 0;
        queue<int> q;
        q.push(0);
        while (!q.empty()) {
            int node = q.front();
            q.pop();
            for (int neighbor : graph[node]) {
                int nextNode = abs(neighbor);
                int newDist = dist[node] + (neighbor > 0 ? 0 : 1);
                if (newDist < dist[nextNode]) {
                    dist[nextNode] = newDist;
                    q.push(nextNode);
                }
            }
        }

        return dist[n - 1];
    }
};