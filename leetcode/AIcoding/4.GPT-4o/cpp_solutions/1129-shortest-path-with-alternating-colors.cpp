#include <vector>
#include <queue>
#include <utility>

using namespace std;

class Solution {
public:
    vector<vector<int>> shortestAlternatingPaths(int n, vector<vector<int>>& redEdges, vector<vector<int>>& blueEdges) {
        vector<vector<int>> graphRed(n), graphBlue(n);
        for (const auto& edge : redEdges) {
            graphRed[edge[0]].push_back(edge[1]);
        }
        for (const auto& edge : blueEdges) {
            graphBlue[edge[0]].push_back(edge[1]);
        }

        vector<vector<int>> dist(n, vector<int>(2, -1));
        queue<pair<int, int>> q;
        q.push({0, 0}); // starting with red
        dist[0][0] = 0;
        q.push({0, 1}); // starting with blue
        dist[0][1] = 0;

        while (!q.empty()) {
            auto [node, color] = q.front(); q.pop();
            if (color == 0) {
                for (int neighbor : graphBlue[node]) {
                    if (dist[neighbor][1] == -1) {
                        dist[neighbor][1] = dist[node][0] + 1;
                        q.push({neighbor, 1});
                    }
                }
            } else {
                for (int neighbor : graphRed[node]) {
                    if (dist[neighbor][0] == -1) {
                        dist[neighbor][0] = dist[node][1] + 1;
                        q.push({neighbor, 0});
                    }
                }
            }
        }

        vector<int> result(n, -1);
        for (int i = 0; i < n; ++i) {
            if (dist[i][0] != -1) {
                if (result[i] == -1) result[i] = dist[i][0];
                else result[i] = min(result[i], dist[i][0]);
            }
            if (dist[i][1] != -1) {
                if (result[i] == -1) result[i] = dist[i][1];
                else result[i] = min(result[i], dist[i][1]);
            }
        }

        return result;
    }
};