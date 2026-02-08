#include <vector>
#include <queue>
#include <tuple>

using namespace std;

class Solution {
public:
    int shortestPathLength(vector<vector<int>>& graph) {
        int n = graph.size();
        if (n == 1) return 0;

        queue<tuple<int, int, int>> q;
        vector<vector<bool>> visited(n, vector<bool>(1 << n, false));

        for (int i = 0; i < n; ++i) {
            q.push({i, 1 << i, 0});
            visited[i][1 << i] = true;
        }

        while (!q.empty()) {
            auto [node, mask, dist] = q.front();
            q.pop();

            for (int neighbor : graph[node]) {
                int newMask = mask | (1 << neighbor);
                if (newMask == (1 << n) - 1) {
                    return dist + 1;
                }
                if (!visited[neighbor][newMask]) {
                    visited[neighbor][newMask] = true;
                    q.push({neighbor, newMask, dist + 1});
                }
            }
        }

        return -1;
    }
};