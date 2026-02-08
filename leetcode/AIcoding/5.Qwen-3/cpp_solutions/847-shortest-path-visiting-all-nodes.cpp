#include <iostream>
#include <vector>
#include <queue>
#include <bitset>

using namespace std;

class Solution {
public:
    int shortestPathLength(vector<vector<int>>& graph) {
        int n = graph.size();
        int allVisited = (1 << n) - 1;
        vector<bitset<100>> visited(n, bitset<100>());
        queue<pair<int, int>> q;

        for (int i = 0; i < n; ++i) {
            q.push({i, 1 << i});
            visited[i][1 << i] = true;
        }

        int steps = 0;
        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                auto [node, mask] = q.front();
                q.pop();

                if (mask == allVisited) return steps;

                for (int neighbor : graph[node]) {
                    int newMask = mask | (1 << neighbor);
                    if (!visited[neighbor][newMask]) {
                        visited[neighbor][newMask] = true;
                        q.push({neighbor, newMask});
                    }
                }
            }
            ++steps;
        }

        return -1;
    }
};