#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minimumTime(int n, vector<vector<int>>& relations, vector<int>& time) {
        vector<int> inDegree(n, 0);
        vector<vector<int>> adj(n);
        for (auto& relation : relations) {
            adj[relation[0] - 1].push_back(relation[1] - 1);
            inDegree[relation[1] - 1]++;
        }

        queue<int> q;
        vector<int> maxTime(n, 0);
        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) {
                q.push(i);
                maxTime[i] = time[i];
            }
        }

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            for (int v : adj[u]) {
                maxTime[v] = max(maxTime[v], maxTime[u] + time[v]);
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        int result = 0;
        for (int t : maxTime) {
            result = max(result, t);
        }

        return result;
    }
};