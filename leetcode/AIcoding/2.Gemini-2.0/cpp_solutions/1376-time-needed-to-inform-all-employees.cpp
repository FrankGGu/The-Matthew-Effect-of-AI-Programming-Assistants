#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int numOfMinutes(int n, int headID, vector<int>& manager, vector<int>& informTime) {
        vector<vector<int>> adj(n);
        for (int i = 0; i < n; ++i) {
            if (manager[i] != -1) {
                adj[manager[i]].push_back(i);
            }
        }

        queue<pair<int, int>> q;
        q.push({headID, 0});
        int max_time = 0;

        while (!q.empty()) {
            int u = q.front().first;
            int time = q.front().second;
            q.pop();

            max_time = max(max_time, time);

            for (int v : adj[u]) {
                q.push({v, time + informTime[u]});
            }
        }

        return max_time;
    }
};