#include <vector>
#include <queue>
#include <tuple>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCost(int maxTime, vector<vector<int>>& edges, vector<int>& passingFees) {
        int n = passingFees.size();
        vector<vector<pair<int, int>>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].emplace_back(edge[1], edge[2]);
            graph[edge[1]].emplace_back(edge[0], edge[2]);
        }

        vector<vector<int>> dp(n, vector<int>(maxTime + 1, INT_MAX));
        dp[0][0] = passingFees[0];

        using State = tuple<int, int, int>;
        priority_queue<State, vector<State>, greater<State>> pq;
        pq.emplace(passingFees[0], 0, 0);

        while (!pq.empty()) {
            auto [cost, node, time] = pq.top();
            pq.pop();

            if (time > maxTime) continue;
            if (node == n - 1) return cost;

            for (const auto& [nextNode, travelTime] : graph[node]) {
                int nextTime = time + travelTime;
                if (nextTime <= maxTime) {
                    int nextCost = cost + passingFees[nextNode];
                    if (nextCost < dp[nextNode][nextTime]) {
                        dp[nextNode][nextTime] = nextCost;
                        pq.emplace(nextCost, nextNode, nextTime);
                    }
                }
            }
        }

        int result = INT_MAX;
        for (int time = 0; time <= maxTime; ++time) {
            result = min(result, dp[n - 1][time]);
        }

        return result == INT_MAX ? -1 : result;
    }
};