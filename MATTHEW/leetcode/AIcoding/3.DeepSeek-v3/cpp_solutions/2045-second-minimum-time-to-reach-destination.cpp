class Solution {
public:
    int secondMinimum(int n, vector<vector<int>>& edges, int time, int change) {
        vector<vector<int>> adj(n + 1);
        for (auto& e : edges) {
            adj[e[0]].push_back(e[1]);
            adj[e[1]].push_back(e[0]);
        }

        vector<int> dist1(n + 1, INT_MAX);
        vector<int> dist2(n + 1, INT_MAX);
        queue<pair<int, int>> q;
        q.push({1, 0});
        dist1[1] = 0;

        while (!q.empty()) {
            auto [node, d] = q.front();
            q.pop();

            for (int neighbor : adj[node]) {
                if (d + 1 < dist1[neighbor]) {
                    dist2[neighbor] = dist1[neighbor];
                    dist1[neighbor] = d + 1;
                    q.push({neighbor, d + 1});
                } else if (d + 1 > dist1[neighbor] && d + 1 < dist2[neighbor]) {
                    dist2[neighbor] = d + 1;
                    q.push({neighbor, d + 1});
                }
            }
        }

        int totalTime = 0;
        int steps = dist2[n];
        for (int i = 0; i < steps; ++i) {
            totalTime += time;
            if (i != steps - 1 && (totalTime / change) % 2 == 1) {
                totalTime = (totalTime / change + 1) * change;
            }
        }
        return totalTime;
    }
};