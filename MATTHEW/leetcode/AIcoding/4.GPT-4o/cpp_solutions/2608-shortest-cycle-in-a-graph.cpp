#include <vector>
#include <queue>
#include <limits>

class Solution {
public:
    int findShortestCycle(int n, std::vector<std::vector<int>>& edges) {
        std::vector<std::vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        int shortestCycle = std::numeric_limits<int>::max();

        for (int start = 0; start < n; ++start) {
            std::vector<int> distance(n, -1);
            std::queue<std::pair<int, int>> q;
            q.push({start, 0});
            distance[start] = 0;

            while (!q.empty()) {
                auto [node, dist] = q.front(); q.pop();

                for (const int neighbor : graph[node]) {
                    if (distance[neighbor] == -1) {
                        distance[neighbor] = dist + 1;
                        q.push({neighbor, dist + 1});
                    } else if (neighbor != start) {
                        shortestCycle = std::min(shortestCycle, dist + 1 + distance[neighbor]);
                    }
                }
            }
        }

        return shortestCycle == std::numeric_limits<int>::max() ? -1 : shortestCycle;
    }
};