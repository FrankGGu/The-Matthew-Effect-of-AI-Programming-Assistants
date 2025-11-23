#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minRefuelStops(int target, int startFuel, vector<vector<int>>& stations) {
        int n = stations.size();
        priority_queue<int> pq;
        int prev = 0;
        int count = 0;
        int current = startFuel;

        for (int i = 0; i <= n; ++i) {
            int dist = (i == n) ? target - prev : stations[i][0] - prev;
            current -= dist;
            while (current < 0 && !pq.empty()) {
                current += pq.top();
                pq.pop();
                ++count;
            }
            if (i < n) {
                pq.push(stations[i][1]);
            }
            prev = (i == n) ? target : stations[i][0];
        }

        return current < 0 ? -1 : count;
    }
};