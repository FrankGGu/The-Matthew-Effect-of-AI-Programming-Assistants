#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> loudAndRich(vector<vector<int>>& richer, vector<int>& quiet) {
        int n = quiet.size();
        vector<vector<int>> adj(n);
        vector<int> inDegree(n, 0);

        for (auto& r : richer) {
            adj[r[1]].push_back(r[0]);
            inDegree[r[0]]++;
        }

        vector<int> ans(n);
        for (int i = 0; i < n; ++i) {
            ans[i] = i;
        }

        queue<int> q;
        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) {
                q.push(i);
            }
        }

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            for (int v : adj[u]) {
                if (quiet[ans[u]] < quiet[ans[v]]) {
                    ans[v] = ans[u];
                }
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        return ans;
    }
};