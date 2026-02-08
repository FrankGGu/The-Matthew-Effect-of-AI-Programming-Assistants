#include <vector>
#include <queue>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int shortestPathLength(vector<vector<int>>& graph) {
        int n = graph.size();
        if (n == 1) return 0;

        queue<pair<int, int>> q;
        unordered_map<int, unordered_set<int>> visited;

        for (int i = 0; i < n; ++i) {
            int mask = 1 << i;
            q.push({i, mask});
            visited[mask].insert(i);
        }

        int steps = 0;
        int target_mask = (1 << n) - 1;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                auto [node, mask] = q.front();
                q.pop();

                if (mask == target_mask) return steps;

                for (int neighbor : graph[node]) {
                    int new_mask = mask | (1 << neighbor);
                    if (visited[new_mask].count(neighbor) == 0) {
                        visited[new_mask].insert(neighbor);
                        q.push({neighbor, new_mask});
                    }
                }
            }
            steps++;
        }

        return -1;
    }
};