#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numberOfPatterns(int n) {
        unordered_map<int, vector<int>> graph = {
            {1, {2, 4, 5}},
            {2, {1, 3, 5}},
            {3, {2, 4, 5}},
            {4, {1, 5, 6}},
            {5, {1, 2, 3, 4, 6, 7, 8, 9}},
            {6, {3, 5, 8}},
            {7, {5, 8, 9}},
            {8, {5, 7, 9}},
            {9, {5, 6, 8}}
        };

        vector<bool> visited(10, false);
        int count = 0;

        function<void(int, int)> dfs = [&](int node, int steps) {
            if (steps == n) {
                count++;
                return;
            }
            visited[node] = true;
            for (int neighbor : graph[node]) {
                if (!visited[neighbor]) {
                    dfs(neighbor, steps + 1);
                }
            }
            visited[node] = false;
        };

        for (int i = 1; i <= 9; ++i) {
            dfs(i, 1);
        }

        return count;
    }
};