#include <iostream>
#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int secondMinimum(int n, vector<vector<int>>& edges) {
        vector<vector<int>> graph(n + 1);
        for (auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<int> dist1(n + 1, INT_MAX), dist2(n + 1, INT_MAX);
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;
        pq.push({0, 1});
        dist1[1] = 0;

        while (!pq.empty()) {
            auto [time, node] = pq.top();
            pq.pop();

            if (node == n) {
                return dist2[n];
            }

            for (int neighbor : graph[node]) {
                if (dist1[neighbor] > time + 1) {
                    swap(dist1[neighbor], time + 1);
                    pq.push({dist1[neighbor], neighbor});
                } else if (dist1[neighbor] < time + 1 && dist2[neighbor] > time + 1) {
                    dist2[neighbor] = time + 1;
                    pq.push({dist2[neighbor], neighbor});
                }
            }
        }

        return dist2[n] == INT_MAX ? -1 : dist2[n];
    }
};