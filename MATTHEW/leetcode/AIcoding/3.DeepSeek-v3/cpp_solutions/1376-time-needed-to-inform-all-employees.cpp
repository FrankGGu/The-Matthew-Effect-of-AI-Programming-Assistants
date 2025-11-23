#include <vector>
#include <unordered_map>
#include <queue>
using namespace std;

class Solution {
public:
    int numOfMinutes(int n, int headID, vector<int>& manager, vector<int>& informTime) {
        unordered_map<int, vector<int>> graph;
        for (int i = 0; i < n; ++i) {
            if (manager[i] != -1) {
                graph[manager[i]].push_back(i);
            }
        }

        queue<pair<int, int>> q;
        q.push({headID, 0});
        int res = 0;

        while (!q.empty()) {
            auto [current, time] = q.front();
            q.pop();
            res = max(res, time);
            for (int subordinate : graph[current]) {
                q.push({subordinate, time + informTime[current]});
            }
        }

        return res;
    }
};