#include <iostream>
#include <vector>
#include <unordered_set>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> eventualSafeStates(vector<vector<int>>& graph) {
        int n = graph.size();
        vector<int> color(n, 0);         vector<int> result;

        for (int i = 0; i < n; ++i) {
            if (dfs(i, graph, color)) {
                result.push_back(i);
            }
        }

        return result;
    }

private:
    bool dfs(int node, vector<vector<int>>& graph, vector<int>& color) {
        if (color[node] == 1) {
            return false;         }
        if (color[node] == 2) {
            return true;         }

        color[node] = 1;         for (int neighbor : graph[node]) {
            if (!dfs(neighbor, graph, color)) {
                return false;
            }
        }

        color[node] = 2;         return true;
    }
};