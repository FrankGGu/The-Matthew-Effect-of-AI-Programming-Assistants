#include <iostream>
#include <vector>
#include <stack>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxEmployees(vector<int>& favorite) {
        int n = favorite.size();
        vector<bool> visited(n, false);
        vector<bool> inStack(n, false);
        vector<int> low(n), disc(n);
        int time = 0;
        int result = 0;

        function<void(int, int, vector<vector<int>>&)> dfs = [&](int u, int parent, vector<vector<int>>& graph) {
            disc[u] = low[u] = ++time;
            inStack[u] = true;
            for (int v : graph[u]) {
                if (v == parent) continue;
                if (!disc[v]) {
                    dfs(v, u, graph);
                    low[u] = min(low[u], low[v]);
                    if (low[v] >= disc[u]) {
                        if (u == parent) {
                            int count = 0;
                            for (int w : graph[u]) {
                                if (w != parent) {
                                    count++;
                                }
                            }
                            result += count;
                        } else {
                            int cycleSize = 0;
                            int current = v;
                            while (current != u) {
                                cycleSize++;
                                current = favorite[current];
                            }
                            cycleSize++;
                            result += cycleSize;
                        }
                    }
                } else if (inStack[v]) {
                    low[u] = min(low[u], disc[v]);
                }
            }
            inStack[u] = false;
        };

        vector<vector<int>> graph(n);
        for (int i = 0; i < n; ++i) {
            graph[i].push_back(favorite[i]);
            graph[favorite[i]].push_back(i);
        }

        for (int i = 0; i < n; ++i) {
            if (!disc[i]) {
                dfs(i, -1, graph);
            }
        }

        return result;
    }
};