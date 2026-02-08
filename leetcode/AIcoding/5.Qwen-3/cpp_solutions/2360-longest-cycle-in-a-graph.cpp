#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int longestCycle(int n, vector<int>& edges) {
        vector<vector<int>> graph(n);
        vector<int> in_degree(n, 0);
        for (int i = 0; i < edges.size(); i += 2) {
            int u = edges[i];
            int v = edges[i + 1];
            graph[u].push_back(v);
            in_degree[v]++;
        }

        queue<int> q;
        for (int i = 0; i < n; ++i) {
            if (in_degree[i] == 0) {
                q.push(i);
            }
        }

        while (!q.empty()) {
            int u = q.front();
            q.pop();
            for (int v : graph[u]) {
                in_degree[v]--;
                if (in_degree[v] == 0) {
                    q.push(v);
                }
            }
        }

        unordered_map<int, int> visited;
        int max_cycle = 0;

        for (int i = 0; i < n; ++i) {
            if (in_degree[i] != 0) {
                int current = i;
                int steps = 0;
                while (true) {
                    if (visited.find(current) != visited.end()) {
                        if (visited[current] == i) {
                            max_cycle = max(max_cycle, steps);
                        }
                        break;
                    }
                    visited[current] = i;
                    current = graph[current][0];
                    steps++;
                }
            }
        }

        return max_cycle == 0 ? -1 : max_cycle;
    }
};