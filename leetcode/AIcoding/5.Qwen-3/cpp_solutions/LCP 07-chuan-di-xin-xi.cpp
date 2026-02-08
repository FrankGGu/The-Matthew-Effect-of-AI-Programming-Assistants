#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int numWays(int n, vector<vector<int>>& relation, int k) {
        vector<vector<int>> graph(n);
        for (const auto& edge : relation) {
            graph[edge[0]].push_back(edge[1]);
        }

        queue<pair<int, int>> q;
        q.push({0, 0});

        int count = 0;

        while (!q.empty()) {
            auto [node, steps] = q.front();
            q.pop();

            if (steps == k) {
                if (node == n - 1) {
                    count++;
                }
                continue;
            }

            for (int neighbor : graph[node]) {
                q.push({neighbor, steps + 1});
            }
        }

        return count;
    }
};