#include <vector>

using namespace std;

class Solution {
public:
    vector<int> countVisitedNodes(vector<int>& edges) {
        int n = edges.size();
        vector<int> ans(n, 0);
        vector<int> inDegree(n, 0);
        for (int edge : edges) {
            inDegree[edge]++;
        }

        vector<int> q;
        for (int i = 0; i < n; i++) {
            if (inDegree[i] == 0) {
                q.push_back(i);
            }
        }

        vector<int> dp(n, 1);
        while (!q.empty()) {
            int u = q.back();
            q.pop_back();
            int v = edges[u];
            ans[u] = 1;
            dp[v] = max(dp[v], dp[u] + 1);
            inDegree[v]--;
            if (inDegree[v] == 0) {
                q.push_back(v);
            }
        }

        vector<bool> visited(n, false);
        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                int curr = i;
                vector<int> path;
                while (!visited[curr]) {
                    visited[curr] = true;
                    path.push_back(curr);
                    curr = edges[curr];
                }

                int cycleStart = -1;
                for (int j = 0; j < path.size(); j++) {
                    if (path[j] == curr) {
                        cycleStart = j;
                        break;
                    }
                }

                int cycleLen = path.size() - cycleStart;
                for (int j = 0; j < path.size(); j++) {
                    if (j >= cycleStart) {
                        ans[path[j]] = cycleLen;
                    } else {
                        ans[path[j]] = dp[path[j]];
                    }
                }
            }
        }

        return ans;
    }
};