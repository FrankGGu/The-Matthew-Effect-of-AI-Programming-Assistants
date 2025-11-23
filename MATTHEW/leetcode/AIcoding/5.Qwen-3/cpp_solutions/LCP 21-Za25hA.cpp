#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    bool isPossibleToCatchAll(int n, vector<vector<int>>& edges, int x, int y) {
        vector<vector<int>> graph(n + 1);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<int> distX(n + 1, -1);
        queue<int> q;
        q.push(x);
        distX[x] = 0;

        while (!q.empty()) {
            int node = q.front();
            q.pop();
            for (int neighbor : graph[node]) {
                if (distX[neighbor] == -1) {
                    distX[neighbor] = distX[node] + 1;
                    q.push(neighbor);
                }
            }
        }

        vector<int> distY(n + 1, -1);
        q.push(y);
        distY[y] = 0;

        while (!q.empty()) {
            int node = q.front();
            q.pop();
            for (int neighbor : graph[node]) {
                if (distY[neighbor] == -1) {
                    distY[neighbor] = distY[node] + 1;
                    q.push(neighbor);
                }
            }
        }

        for (int i = 1; i <= n; ++i) {
            if (distX[i] == -1 || distY[i] == -1) {
                return false;
            }
            if (distX[i] > distY[i]) {
                return false;
            }
        }

        return true;
    }
};