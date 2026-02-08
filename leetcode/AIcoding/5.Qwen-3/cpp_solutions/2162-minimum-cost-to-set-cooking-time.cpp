#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minTimeToCook(int targetTime, int maxTime) {
        vector<int> times = {1, 2, 5, 10, 20, 30, 60};
        vector<int> costs = {1, 2, 3, 4, 5, 6, 7};

        vector<int> dp(targetTime + 1, -1);
        dp[0] = 0;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;
        pq.push({0, 0});

        while (!pq.empty()) {
            int time = pq.top().second;
            int cost = pq.top().first;
            pq.pop();

            if (time > targetTime) continue;

            for (int i = 0; i < times.size(); ++i) {
                int nextTime = time + times[i];
                int nextCost = cost + costs[i];
                if (nextTime <= targetTime && (dp[nextTime] == -1 || nextCost < dp[nextTime])) {
                    dp[nextTime] = nextCost;
                    pq.push({nextCost, nextTime});
                }
            }
        }

        return dp[targetTime];
    }
};