#include <vector>
#include <queue>
#include <tuple>
#include <limits>

using namespace std;

class Solution {
public:
    int findCheapestPrice(int n, vector<vector<int>>& flights, int src, int dst, int k) {
        vector<vector<pair<int, int>>> graph(n);
        for (const auto& flight : flights) {
            graph[flight[0]].emplace_back(flight[1], flight[2]);
        }

        priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<tuple<int, int, int>>> pq;
        pq.emplace(0, src, 0);

        vector<int> minCost(n, numeric_limits<int>::max());
        minCost[src] = 0;

        while (!pq.empty()) {
            auto [cost, city, stops] = pq.top();
            pq.pop();
            if (city == dst) return cost;
            if (stops > k) continue;
            for (const auto& [nextCity, price] : graph[city]) {
                if (cost + price < minCost[nextCity]) {
                    minCost[nextCity] = cost + price;
                    pq.emplace(cost + price, nextCity, stops + 1);
                }
            }
        }

        return minCost[dst] == numeric_limits<int>::max() ? -1 : minCost[dst];
    }
};