#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestSpecialPath(int n, vector<int>& a, vector<int>& b) {
        vector<vector<int>> adj(n);
        for (int i = 0; i < a.size(); ++i) {
            adj[a[i] - 1].push_back(b[i] - 1);
            adj[b[i] - 1].push_back(a[i] - 1);
        }

        int maxLen = 0;
        vector<bool> visited(n, false);

        function<void(int, int)> dfs = [&](int u, int len) {
            visited[u] = true;
            maxLen = max(maxLen, len);

            for (int v : adj[u]) {
                if (!visited[v]) {
                    dfs(v, len + 1);
                }
            }

            visited[u] = false;
        };

        for (int i = 0; i < n; ++i) {
            dfs(i, 0);
        }

        return maxLen;
    }
};