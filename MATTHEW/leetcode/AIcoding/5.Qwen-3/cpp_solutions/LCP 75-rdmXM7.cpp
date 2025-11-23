#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int findCheapestPrice(int n, vector<vector<int>>& flights, int src, int dst, int k) {
        unordered_map<int, vector<pair<int, int>>> graph;
        for (auto& flight : flights) {
            graph[flight[0]].push_back({flight[1], flight[2]});
        }

        vector<int> dist(n, INT_MAX);
        dist[src] = 0;

        queue<pair<int, int>> q;
        q.push({src, 0});

        while (!q.empty() && k >= 0) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                auto [node, cost] = q.front();
                q.pop();
                for (auto& [neighbor, price] : graph[node]) {
                    if (dist[neighbor] > cost + price) {
                        dist[neighbor] = cost + price;
                        q.push({neighbor, dist[neighbor]});
                    }
                }
            }
            --k;
        }

        return dist[dst] == INT_MAX ? -1 : dist[dst];
    }
};