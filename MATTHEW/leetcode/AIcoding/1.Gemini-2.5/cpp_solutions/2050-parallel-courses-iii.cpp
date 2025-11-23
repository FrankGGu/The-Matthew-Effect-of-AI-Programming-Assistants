#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minimumTime(int n, vector<vector<int>>& relations, vector<int>& time) {
        vector<int> inDegree(n, 0);
        vector<vector<int>> adj(n);
        for (auto& relation : relations) {
            int prevCourse = relation[0] - 1;
            int nextCourse = relation[1] - 1;
            adj[prevCourse].push_back(nextCourse);
            inDegree[nextCourse]++;
        }

        queue<int> q;
        vector<int> startTime(n, 0);
        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) {
                q.push(i);
                startTime[i] = time[i];
            }
        }

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            for (int v : adj[u]) {
                startTime[v] = max(startTime[v], startTime[u] + time[v]);
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        int maxTime = 0;
        for (int i = 0; i < n; ++i) {
            maxTime = max(maxTime, startTime[i]);
        }

        return maxTime;
    }
};