#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int largestPathValue(string colors, vector<vector<int>>& edges) {
        int n = colors.size();
        vector<int> indegree(n, 0);
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            indegree[edge[1]]++;
        }

        queue<int> q;
        for (int i = 0; i < n; i++) {
            if (indegree[i] == 0) {
                q.push(i);
            }
        }

        vector<vector<int>> count(n, vector<int>(26, 0));
        for (int i = 0; i < n; i++) {
            count[i][colors[i] - 'a'] = 1;
        }

        int visited = 0;
        int ans = 0;

        while (!q.empty()) {
            int u = q.front();
            q.pop();
            visited++;

            ans = max(ans, *max_element(count[u].begin(), count[u].end()));

            for (int v : adj[u]) {
                for (int i = 0; i < 26; i++) {
                    count[v][i] = max(count[v][i], count[u][i] + (colors[v] - 'a' == i));
                }
                indegree[v]--;
                if (indegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        return visited == n ? ans : -1;
    }
};