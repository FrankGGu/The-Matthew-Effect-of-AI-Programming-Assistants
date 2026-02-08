#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestPath(vector<int>& parent, string s) {
        int n = parent.size();
        vector<vector<int>> adj(n);
        for (int i = 1; i < n; ++i) {
            adj[parent[i]].push_back(i);
        }

        int maxLen = 0;

        function<int(int)> dfs = [&](int u) {
            int maxChildLen1 = 0, maxChildLen2 = 0;
            for (int v : adj[u]) {
                int childLen = dfs(v);
                if (s[u] != s[v]) {
                    if (childLen > maxChildLen1) {
                        maxChildLen2 = maxChildLen1;
                        maxChildLen1 = childLen;
                    } else if (childLen > maxChildLen2) {
                        maxChildLen2 = childLen;
                    }
                }
            }
            maxLen = max(maxLen, maxChildLen1 + maxChildLen2 + 1);
            return maxChildLen1 + 1;
        };

        dfs(0);
        return maxLen;
    }
};