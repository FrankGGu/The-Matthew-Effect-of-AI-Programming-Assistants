#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int findCheapestPrice(int n, vector<vector<int>>& flights, int src, int dst, int k) {
        vector<vector<pair<int, int>>> graph(n);
        for (auto& flight : flights) {
            graph[flight[0]].push_back({flight[1], flight[2]});
        }

        vector<int> dist(n, INT_MAX);
        dist[src] = 0;

        for (int i = 0; i <= k; ++i) {
            vector<int> temp(dist);
            for (int u = 0; u < n; ++u) {
                if (dist[u] != INT_MAX) {
                    for (auto& [v, price] : graph[u]) {
                        if (dist[u] + price < temp[v]) {
                            temp[v] = dist[u] + price;
                        }
                    }
                }
            }
            dist = temp;
        }

        return dist[dst] == INT_MAX ? -1 : dist[dst];
    }
};