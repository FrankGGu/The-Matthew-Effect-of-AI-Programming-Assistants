#include <vector>

using namespace std;

class Solution {
public:
    int minTime(int n, vector<vector<int>>& edges, vector<bool>& hasApple) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        return dfs(0, -1, adj, hasApple) * 2;
    }

private:
    int dfs(int node, int parent, vector<vector<int>>& adj, vector<bool>& hasApple) {
        int time = 0;
        for (int neighbor : adj[node]) {
            if (neighbor != parent) {
                int childTime = dfs(neighbor, node, adj, hasApple);
                if (childTime > 0 || hasApple[neighbor]) {
                    time += childTime + 1;
                }
            }
        }
        return time;
    }
};