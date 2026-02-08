#include <vector>
#include <queue>
#include <utility>
#include <climits>

class Solution {
public:
    int secondMinimum(int n, std::vector<std::vector<int>>& edges, int time, int change) {
        std::vector<std::vector<int>> adj(n + 1);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        std::vector<int> dist1(n + 1, INT_MAX);
        std::vector<int> dist2(n + 1, INT_MAX);

        std::priority_queue<std::pair<int, int>, std::vector<std::pair<int, int>>, std::greater<std::pair<int, int>>> pq;

        dist1[1] = 0;
        pq.push({0, 1});

        while (!pq.empty()) {
            auto [currentTime, u] = pq.top();
            pq.pop();

            if (currentTime > dist2[u]) {
                continue;
            }

            int leaveTime = currentTime;
            if ((currentTime / change) % 2 == 1) {
                leaveTime = (currentTime / change + 1) * change;
            }

            int nextTime = leaveTime + time;

            for (int v : adj[u]) {
                if (nextTime < dist1[v]) {
                    dist2[v] = dist1[v];
                    dist1[v] = nextTime;
                    pq.push({dist1[v], v});
                } else if (nextTime > dist1[v] && nextTime < dist2[v]) {
                    dist2[v] = nextTime;
                    pq.push({dist2[v], v});
                }
            }
        }

        return dist2[n];
    }
};