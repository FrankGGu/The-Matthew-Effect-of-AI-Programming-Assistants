#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int minimumTimeToCompleteAllTasks(vector<int>& taskTimes, vector<vector<int>>& dependencies) {
        int n = taskTimes.size();
        vector<int> inDegree(n, 0);
        vector<vector<int>> graph(n);

        for (const auto& dep : dependencies) {
            int u = dep[0];
            int v = dep[1];
            graph[u].push_back(v);
            inDegree[v]++;
        }

        queue<int> q;
        vector<int> time(n, 0);

        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) {
                q.push(i);
                time[i] = taskTimes[i];
            }
        }

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            for (int v : graph[u]) {
                time[v] = max(time[v], time[u] + taskTimes[v]);
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        return *max_element(time.begin(), time.end());
    }
};