#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int numOfMinutes(int n, int headID, vector<int>& manager, vector<int>& informTime) {
        vector<vector<int>> graph(n);
        for (int i = 0; i < n; ++i) {
            if (manager[i] != -1) {
                graph[manager[i]].push_back(i);
            }
        }

        queue<pair<int, int>> q;
        q.push({headID, 0});

        int maxTime = 0;

        while (!q.empty()) {
            auto [current, time] = q.front();
            q.pop();
            maxTime = max(maxTime, time);
            for (int next : graph[current]) {
                q.push({next, time + informTime[current]});
            }
        }

        return maxTime;
    }
};