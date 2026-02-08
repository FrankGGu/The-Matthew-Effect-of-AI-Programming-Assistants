#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int maximumDetonation(vector<vector<int>>& bombs) {
        int n = bombs.size();
        vector<vector<int>> adj(n);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i == j) continue;
                long long x1 = bombs[i][0], y1 = bombs[i][1], r1 = bombs[i][2];
                long long x2 = bombs[j][0], y2 = bombs[j][1];
                long long distSq = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
                if (distSq <= r1 * r1) {
                    adj[i].push_back(j);
                }
            }
        }

        int maxDetonated = 0;
        for (int i = 0; i < n; ++i) {
            vector<bool> visited(n, false);
            queue<int> q;
            q.push(i);
            visited[i] = true;
            int detonated = 0;

            while (!q.empty()) {
                int u = q.front();
                q.pop();
                detonated++;

                for (int v : adj[u]) {
                    if (!visited[v]) {
                        visited[v] = true;
                        q.push(v);
                    }
                }
            }
            maxDetonated = max(maxDetonated, detonated);
        }

        return maxDetonated;
    }
};