#include <vector>
#include <queue>
using namespace std;

class Solution {
public:
    bool isBipartite(vector<vector<int>>& graph) {
        int n = graph.size();
        vector<int> color(n, 0);
        for (int i = 0; i < n; ++i) {
            if (color[i] != 0) continue;
            queue<int> q;
            q.push(i);
            color[i] = 1;
            while (!q.empty()) {
                int cur = q.front();
                q.pop();
                for (int neighbor : graph[cur]) {
                    if (color[neighbor] == 0) {
                        color[neighbor] = 3 - color[cur];
                        q.push(neighbor);
                    } else if (color[neighbor] == color[cur]) {
                        return false;
                    }
                }
            }
        }
        return true;
    }
};