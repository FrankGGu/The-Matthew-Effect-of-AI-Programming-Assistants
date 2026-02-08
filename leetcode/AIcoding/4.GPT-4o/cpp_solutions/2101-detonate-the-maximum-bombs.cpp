class Solution {
public:
    int maximumDetonations(vector<vector<int>>& bombs) {
        int n = bombs.size();
        vector<vector<int>> graph(n);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i != j) {
                    long long dx = bombs[i][0] - bombs[j][0];
                    long long dy = bombs[i][1] - bombs[j][1];
                    long long distance = dx * dx + dy * dy;
                    long long radius = (long long)bombs[i][2] * bombs[i][2];
                    if (distance <= radius) {
                        graph[i].push_back(j);
                    }
                }
            }
        }

        int maxDetonations = 0;

        for (int i = 0; i < n; ++i) {
            vector<bool> visited(n, false);
            queue<int> q;
            q.push(i);
            visited[i] = true;
            int count = 0;

            while (!q.empty()) {
                int node = q.front();
                q.pop();
                count++;

                for (int neighbor : graph[node]) {
                    if (!visited[neighbor]) {
                        visited[neighbor] = true;
                        q.push(neighbor);
                    }
                }
            }

            maxDetonations = max(maxDetonations, count);
        }

        return maxDetonations;
    }
};