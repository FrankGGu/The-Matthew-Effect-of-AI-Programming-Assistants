#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> trainingPlan(int n, vector<vector<int>>& relations, vector<int>& time) {
        vector<int> inDegree(n);
        vector<vector<int>> adj(n);
        vector<int> ans(n);

        for (auto& relation : relations) {
            int prev = relation[0];
            int next = relation[1];
            adj[prev].push_back(next);
            inDegree[next]++;
        }

        queue<int> q;
        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) {
                q.push(i);
                ans[i] = time[i];
            }
        }

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            for (int v : adj[u]) {
                inDegree[v]--;
                ans[v] = max(ans[v], ans[u] + time[v]);
                if (inDegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        return ans;
    }
};